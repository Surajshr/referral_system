import 'dart:convert';
import 'dart:io';
import 'package:referral_app/app/view/app_imports.dart';
import 'package:referral_app/core/constants/api_constants.dart';
import 'package:referral_app/core/constants/environment_constants.dart';
import 'package:referral_app/core/constants/storage_constant.dart';
import 'package:referral_app/core/constants/string_constants.dart';
import 'package:referral_app/core/di/di.dart';
import 'package:referral_app/core/internet_check/internet_connectivity_checker.dart';

import 'package:referral_app/core/network/client/base_client.dart';
import 'package:referral_app/core/network/functions/get_header.dart';
import 'package:referral_app/core/route/route_imports.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:referral_app/core/utils/show_loading_dialog.dart';

import 'package:shared_preferences/shared_preferences.dart';

/// A concrete implementation of [BaseClient] that handles HTTP requests using Dio.
///
/// This class provides methods for making HTTP requests (GET, POST, PUT, PATCH, DELETE)
/// with features like:
/// - Automatic token refresh on 401 errors
/// - Request caching
/// - Loading dialog management
/// - Multipart form data support
/// - Custom headers
/// - Request logging
/// - Error handling
///
/// The class uses Dio as the underlying HTTP client and includes interceptors for
/// logging request/response details during development.
///
/// Example usage:
/// ```dart
/// final client = BaseClientImpl();
///
/// // Make a GET request
/// final response = await client.getRequest(
///   path: '/users',
///   requiresAuthorization: true,
///   shouldCache: true
/// );
///
/// // Make a POST request with data
/// final response = await client.postRequest(
///   path: '/users',
///   data: {'name': 'John Doe'},
///   contentTypeIsMultiPart: false
/// );
/// ```
class BaseClientImpl extends BaseClient {
  /// The underlying Dio HTTP client instance used for making requests
  final Dio _dio;
  final InternetConnectivityChecker _internetConnectivityChecker;

  /// Creates a new BaseClientImpl instance and configures Dio with logging interceptors
  /// for development debugging purposes. The logger will show request headers and bodies
  /// as well as any errors that occur.
  BaseClientImpl(this._internetConnectivityChecker) : _dio = Dio() {
    _dio.interceptors.add(
      PrettyDioLogger(
        error: true,
        requestBody: true,
        requestHeader: true,
        request: true,
        responseBody: false,
      ),
    );
  }

  /// Makes a GET request to the specified endpoint with optional caching support.
  ///
  /// If [shouldCache] is true and a network error occurs, attempts to return cached data.
  /// If [showDialog] is true, displays a loading indicator during the request.
  /// Automatically handles token refresh if an authorization error occurs.
  ///
  /// Parameters:
  /// - [baseUrl]: Optional base URL to prepend to the path
  /// - [optionalHeaders]: Additional headers to include in the request
  /// - [queryParameters]: URL query parameters
  /// - [path]: The API endpoint path
  /// - [showDialog]: Whether to show a loading dialog during the request
  /// - [shouldCache]: Whether to cache the response
  /// - [requiresAuthorization]: Whether the request requires authorization headers
  ///
  /// Returns the Response object or null if the request fails
  @override
  Future<Response<dynamic>?> getRequest({
    String baseUrl = "",
    Map<String, String>? optionalHeaders,
    Map<String, dynamic>? queryParameters,
    required String path,
    bool showDialog = false,
    bool shouldCache = true,
    bool requiresAuthorization = true,
  }) async {
    Response? response;
    // if (showDialog) showLoadingDialog();

    // Check internet connectivity first
    final internetCheck = await _checkInternetConnectivity();
    if (internetCheck != null) {
      if (showDialog) hideLoadingDialog();
      return internetCheck;
    }

    try {
      Map<String, String> header = getHeader(
        requiresAuthorization: requiresAuthorization,
      );
      if (optionalHeaders != null) {
        header.addAll(optionalHeaders);
      }

      response = await _dio.get(
        baseUrl + path,
        queryParameters: queryParameters,
        options: Options(
          persistentConnection: true,
          headers: header,
          sendTimeout: const Duration(seconds: 40),
          receiveTimeout: const Duration(seconds: 40),
        ),
      );
      print(baseUrl + path + response.statusCode.toString());
      if (shouldCache) {
        di<SharedPreferences>().setString(
          path,
          jsonEncode(response.data).toString(),
        );
      }
    } on DioException catch (e) {
      final responseAfterAuthError = await _handleAuthError(
        e,
        () => getRequest(
          baseUrl: baseUrl,
          optionalHeaders: optionalHeaders,
          queryParameters: queryParameters,
          path: path,
          showDialog: showDialog,
          shouldCache: shouldCache,
        ),
      );
      response = responseAfterAuthError;
      print("DioException getreq error @path$baseUrl $path: $e");
      if (shouldCache && e.error is SocketException) {
        response = getCachedResponse(path);
      }
    } catch (e) {
      print("Catch error: $e");
      if (shouldCache && e is SocketException) {
        response = getCachedResponse(path);
      }
    }
    if (showDialog) hideLoadingDialog();
    return response;
  }

  /// Attempts to refresh the access token using the stored refresh token.
  ///
  /// Makes a POST request to the refresh token endpoint with the current refresh token.
  /// If successful, stores the new access and refresh tokens.
  ///
  /// Returns true if token refresh was successful, false otherwise.
  Future<bool> getNewAccessToken() async {
    try {
      final refreshToken = di<SharedPreferences>().getString(
        StorageConstant.kRefreshToken,
      );
      final response = await _dio.post(
        EnvironmentConstants.baseUrl + ApiConstants.kRefreshToken,
        data: {'refreshToken': refreshToken},
        options: Options(
          sendTimeout: const Duration(seconds: 40),
          receiveTimeout: const Duration(seconds: 40),
        ),
      );
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        await di<SharedPreferences>().setString(
          StorageConstant.kSessionToken,
          data['data']['accessToken'] as String,
        );
        await di<SharedPreferences>().setString(
          StorageConstant.kRefreshToken,
          data['data']['refreshToken'] as String,
        );
        return true;
      } else {
        print(
          "Failed to refresh token: ${response.statusCode} - ${response.data}",
        );
        return false;
      }
    } on DioException catch (e) {
      print("DioException while refreshing token: ${e.message}");
      if (e.response != null) {
        print("Response data: ${e.response?.data}");
      }
      return false;
    } catch (e) {
      print("Unexpected error while refreshing token: $e");
      return false;
    }
  }

  /// Retrieves a cached response for the given endpoint from SharedPreferences.
  ///
  /// Creates a new Response object with the cached data if available.
  ///
  /// Parameters:
  /// - [endpoint]: The API endpoint path used as the cache key
  ///
  /// Returns the cached Response object or null if no cache exists
  Response? getCachedResponse(String endpoint) {
    String? cachedResponse = di<SharedPreferences>().getString(endpoint);
    Response? response = cachedResponse != null
        ? Response(
            requestOptions: RequestOptions(),
            data: cachedResponse,
            statusCode: 200,
          )
        : null;
    return response;
  }

  /// Makes a POST request to the specified endpoint.
  ///
  /// Supports multipart form data and custom content types.
  /// Automatically handles token refresh if an authorization error occurs.
  ///
  /// Parameters:
  /// - [baseUrl]: Optional base URL to prepend to the path
  /// - [optionalHeaders]: Additional headers to include in the request
  /// - [queryParameters]: URL query parameters
  /// - [data]: The request body data
  /// - [path]: The API endpoint path
  /// - [showDialog]: Whether to show a loading dialog during the request
  /// - [contentTypeIsMultiPart]: Whether the content type is multipart/form-data
  /// - [requiresAuthorization]: Whether the request requires authorization headers
  /// - [setContentType]: Whether to set the Content-Type header
  ///
  /// Returns the Response object or null if the request fails
  @override
  Future<Response?> postRequest({
    String baseUrl = "",
    Map<String, String>? optionalHeaders,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    required String path,
    bool showDialog = false,
    bool contentTypeIsMultiPart = false,
    bool requiresAuthorization = true,
    bool setContentType = true,
  }) async {
    Response? response;

    // Check internet connectivity first
    final internetCheck = await _checkInternetConnectivity();
    if (internetCheck != null) {
      if (showDialog) hideLoadingDialog();
      return internetCheck;
    }

    try {
      print("post req @path:# ${data.toString()} $path");
      Map<String, String> header = getHeader(
        contentTypeIsMultiPart: contentTypeIsMultiPart,
        setContentType: setContentType,
        requiresAuthorization: requiresAuthorization,
      );
      if (optionalHeaders != null) {
        header.addAll(optionalHeaders);
      }

      response = await _dio.post(
        baseUrl + path,
        queryParameters: queryParameters,
        options: Options(
          headers: header,
          sendTimeout: const Duration(seconds: 60),
          receiveTimeout: const Duration(seconds: 60),
        ),
        data: data,
      );
    } on DioException catch (e) {
      print("dio exp post req @path: $path : ${e.response}");
      final responseAfterAuthError = await _handleAuthError(
        e,
        () => postRequest(
          baseUrl: baseUrl,
          optionalHeaders: optionalHeaders,
          queryParameters: queryParameters,
          data: data,
          path: path,
          showDialog: showDialog,
          contentTypeIsMultiPart: contentTypeIsMultiPart,
          requiresAuthorization: requiresAuthorization,
          setContentType: setContentType,
        ),
      );
      print("response after auth error: $responseAfterAuthError");
      response = responseAfterAuthError;
    } catch (e) {
      print("catch post req: $e");
    }
    if (showDialog) hideLoadingDialog();
    return response;
  }

  /// Uploads an image file to the specified endpoint using multipart form data.
  ///
  /// Automatically sets the content type to multipart/form-data and includes
  /// the image file in the request body.
  ///
  /// Parameters:
  /// - [baseUrl]: Optional base URL to prepend to the path
  /// - [path]: The API endpoint path
  /// - [imageFile]: The image file to upload
  /// - [showDialog]: Whether to show a loading dialog during the upload
  /// - [requiresAuthorization]: Whether the request requires authorization headers
  /// - [optionalHeaders]: Additional headers to include in the request
  ///
  /// Returns the Response object or null if the upload fails
  @override
  Future<Response?> uploadImage({
    String baseUrl = "",
    required String path,
    required File imageFile,
    bool showDialog = false,
    bool requiresAuthorization = true,
    Map<String, String>? optionalHeaders,
  }) async {
    Response? response;

    // Check internet connectivity first
    final internetCheck = await _checkInternetConnectivity();
    if (internetCheck != null) {
      if (showDialog) hideLoadingDialog();
      return internetCheck;
    }

    try {
      String fileName = imageFile.path.split('/').last;
      FormData formData = FormData.fromMap({
        'avatar': await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
        ),
      });

      Map<String, String> header = getHeader(
        contentTypeIsMultiPart: true,
        requiresAuthorization: requiresAuthorization,
      );
      if (optionalHeaders != null) {
        header.addAll(optionalHeaders);
      }

      response = await _dio.post(
        baseUrl + path,
        data: formData,
        options: Options(
          headers: header,
          sendTimeout: const Duration(seconds: 40),
          receiveTimeout: const Duration(seconds: 40),
        ),
      );

      print("upload image resp: $response");
    } on DioException catch (e) {
      final responseAfterAuthError = await _handleAuthError(
        e,
        () => uploadImage(
          baseUrl: baseUrl,
          path: path,
          imageFile: imageFile,
          showDialog: showDialog,
          optionalHeaders: optionalHeaders,
        ),
      );
      response = responseAfterAuthError;
      print("dio exp upload image @path: $path : ${e.response}");
    } catch (e) {
      print("catch upload image: $e");
    }
    if (showDialog) hideLoadingDialog();
    return response;
  }

  /// Makes a DELETE request to the specified endpoint.
  ///
  /// Automatically handles token refresh if an authorization error occurs.
  ///
  /// Parameters:
  /// - [baseUrl]: Optional base URL to prepend to the path
  /// - [optionalHeaders]: Additional headers to include in the request
  /// - [data]: The request body data
  /// - [path]: The API endpoint path
  /// - [showDialog]: Whether to show a loading dialog during the request
  /// - [requiresAuthorization]: Whether the request requires authorization headers
  ///
  /// Returns the Response object or null if the request fails
  @override
  Future<Response<dynamic>?> deleteRequest({
    String baseUrl = "",
    Map<String, String>? optionalHeaders,
    Map<String, dynamic>? data,
    required String path,
    bool showDialog = false,
    bool requiresAuthorization = true,
  }) async {
    Response? response;
    if (showDialog) {
      showLoadingDialog();
    }

    // Check internet connectivity first
    final internetCheck = await _checkInternetConnectivity();
    if (internetCheck != null) {
      if (showDialog) hideLoadingDialog();
      return internetCheck;
    }

    try {
      Map<String, String> header = getHeader(
        requiresAuthorization: requiresAuthorization,
      );
      if (optionalHeaders != null) {
        header.addAll(optionalHeaders);
      }
      response = await _dio.delete(
        baseUrl + path,
        options: Options(
          headers: header,
          sendTimeout: const Duration(seconds: 40),
          receiveTimeout: const Duration(seconds: 40),
        ),
        data: data,
      );
      print("delete req resp: $response");
    } on DioException catch (e) {
      final responseAfterAuthError = await _handleAuthError(
        e,
        () => deleteRequest(
          baseUrl: baseUrl,
          optionalHeaders: optionalHeaders,
          data: data,
          path: path,
          showDialog: showDialog,
          requiresAuthorization: requiresAuthorization,
        ),
      );
      response = responseAfterAuthError;
      print("dio exp delete req @path: $path : ${e.response}");
    } catch (e) {
      print("catch delete req: $e");
    }
    if (showDialog) hideLoadingDialog();
    return response;
  }

  /// Makes a PATCH request to the specified endpoint.
  ///
  /// Supports multipart form data and automatically handles token refresh
  /// if an authorization error occurs.
  ///
  /// Parameters:
  /// - [baseUrl]: Optional base URL to prepend to the path
  /// - [optionalHeaders]: Additional headers to include in the request
  /// - [data]: The request body data
  /// - [path]: The API endpoint path
  /// - [showDialog]: Whether to show a loading dialog during the request
  /// - [contentTypeIsMultiPart]: Whether the content type is multipart/form-data
  /// - [requiresAuthorization]: Whether the request requires authorization headers
  ///
  /// Returns the Response object or null if the request fails
  @override
  Future<Response<dynamic>?> patchRequest({
    String baseUrl = "",
    Map<String, String>? optionalHeaders,
    dynamic data,
    required String path,
    bool showDialog = false,
    bool contentTypeIsMultiPart = false,
    bool requiresAuthorization = true,
  }) async {
    Response? response;
    if (showDialog) {
      showLoadingDialog();
    }

    // Check internet connectivity first
    final internetCheck = await _checkInternetConnectivity();
    if (internetCheck != null) {
      if (showDialog) hideLoadingDialog();
      return internetCheck;
    }

    try {
      Map<String, String> header = getHeader(
        contentTypeIsMultiPart: contentTypeIsMultiPart,
        setContentType: true,
        requiresAuthorization: requiresAuthorization,
      );
      if (optionalHeaders != null) {
        header.addAll(optionalHeaders);
      }
      response = await _dio.patch(
        baseUrl + path,
        options: Options(
          headers: header,
          sendTimeout: const Duration(seconds: 40),
          receiveTimeout: const Duration(seconds: 40),
        ),
        data: data,
      );
      print("patch req resp: $response");
    } on DioException catch (e) {
      final responseAfterAuthError = await _handleAuthError(
        e,
        () => patchRequest(
          baseUrl: baseUrl,
          optionalHeaders: optionalHeaders,
          data: data,
          path: path,
          showDialog: showDialog,
          contentTypeIsMultiPart: contentTypeIsMultiPart,
          requiresAuthorization: requiresAuthorization,
        ),
      );
      response = responseAfterAuthError;
      print("dio exp patch req @path: $path : ${e.response}");
    } catch (e) {
      print("catch patch req: $e");
    }
    if (showDialog) hideLoadingDialog();
    return response;
  }

  /// Makes a PUT request to the specified endpoint.
  ///
  /// Automatically handles token refresh if an authorization error occurs.
  ///
  /// Parameters:
  /// - [baseUrl]: Optional base URL to prepend to the path
  /// - [optionalHeaders]: Additional headers to include in the request
  /// - [data]: The request body data
  /// - [path]: The API endpoint path
  /// - [showDialog]: Whether to show a loading dialog during the request
  /// - [requiresAuthorization]: Whether the request requires authorization headers
  ///
  /// Returns the Response object or null if the request fails
  Future<Response?> putRequest({
    String baseUrl = "",
    Map<String, String>? optionalHeaders,
    dynamic data,
    required String path,
    bool showDialog = false,
    bool requiresAuthorization = true,
  }) async {
    Response? response;

    // Check internet connectivity first
    final internetCheck = await _checkInternetConnectivity();
    if (internetCheck != null) {
      if (showDialog) hideLoadingDialog();
      return internetCheck;
    }

    try {
      Map<String, String> header = getHeader(
        requiresAuthorization: requiresAuthorization,
        setContentType: true,
      );
      if (optionalHeaders != null) {
        header.addAll(optionalHeaders);
      }

      response = await _dio.put(
        baseUrl + path,
        options: Options(
          headers: header,
          sendTimeout: const Duration(seconds: 40),
          receiveTimeout: const Duration(seconds: 40),
        ),
        data: data,
      );
    } on DioException catch (e) {
      final responseAfterAuthError = await _handleAuthError(
        e,
        () => putRequest(
          baseUrl: baseUrl,
          optionalHeaders: optionalHeaders,
          data: data,
          path: path,
          showDialog: showDialog,
          requiresAuthorization: requiresAuthorization,
        ),
      );
      response = responseAfterAuthError;
      print("dio exp put req @path: $path : ${e.response}");
    } catch (e) {
      print("catch put req: $e");
    }
    if (showDialog) hideLoadingDialog();
    return response;
  }

  /// Checks internet connectivity before making any HTTP request.
  ///
  /// Returns a Response object with no internet error if connectivity fails,
  /// or null if internet is available.
  Future<Response?> _checkInternetConnectivity() async {
    final hasInternet = await _internetConnectivityChecker
        .isInternetConnected();
    if (!hasInternet) {
      return Response(
        requestOptions: RequestOptions(),
        data: {
          'error': StringConstant.kKeyNoInternet,
          'message': StringConstant.kKeyNoInternetMessage,
          'code': 1001,
          'statusCode': 0,
        },
        statusCode: 0,
      );
    }
    return null;
  }

  /// Checks if a response indicates a token expiration error.
  ///
  /// Examines the response data structure for specific error messages
  /// that indicate an expired token.
  ///
  /// Returns true if the error is a token expiration error, false otherwise.
  bool _isTokenExpiredError(Response? response) {
    if (response?.data == null) return false;
    print("response in isTokenExpiredError: $response");
    final errorData = response!.data;

    // Handle new error format: {"error": "BAD_REQUEST", "message": "...", "code": 1014, "statusCode": 401}
    final errorMessage = errorData['error'] as String?;

    print("errorTitleInIsTokenExpiredError: $errorMessage");

    const validErrorMessages = ['Token expired', 'User Unauthenticated'];

    return validErrorMessages.contains(errorMessage);
  }

  /// Extracts the error message from a response.
  ///
  /// Handles different error response structures and returns a trimmed error message.
  ///
  // /// Returns the error message string or null if no message is found.
  // String? _getErrorMessage(Response? response) {
  //   final errorData = response?.data;
  //   return errorData?['error']?['title'].toString().trim() ??
  //       errorData?['errors']?[0]?['title'].toString().trim();
  // }

  /// Handles authentication errors by attempting token refresh.
  ///
  /// If a 401 error occurs and it's due to token expiration:
  /// 1. Attempts to refresh the token
  /// 2. If successful, retries the original request
  /// 3. If unsuccessful, clears tokens and redirects to login
  ///
  /// Parameters:
  /// - [e]: The DioException that occurred
  /// - [retryRequest]: Callback function to retry the original request
  ///
  /// Returns the response from the retry attempt or the original error response
  Future<Response?> _handleAuthError(
    DioException e,
    Future<Response?> Function() retryRequest,
  ) async {
    if (e.response?.statusCode == 401) {
      if (!_isTokenExpiredError(e.response)) {
        return e.response;
      }

      if (await getNewAccessToken()) {
        return retryRequest();
      } else {
        await di<SharedPreferences>().remove(StorageConstant.kSessionToken);
        await di<SharedPreferences>().remove(StorageConstant.kRefreshToken);

        navigatorKey.currentContext!.go(RouteName.signInBaseScreen);
      }
    }
    return e.response;
  }
}
