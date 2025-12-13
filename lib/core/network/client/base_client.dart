import 'dart:io';

import 'package:dio/dio.dart';

abstract class BaseClient {
  Future<Response<dynamic>?> getRequest({
    String baseUrl = "",
    Map<String, String>? optionalHeaders,
    Map<String, dynamic>? queryParameters,
    required String path,
    bool showDialog = false,
    bool shouldCache = true,
    bool requiresAuthorization = true,
  });
  Future<Response<dynamic>?> postRequest({
    String baseUrl = "",
    Map<String, String>? optionalHeaders,
    dynamic data,
    required String path,
    bool showDialog = false,
    bool contentTypeIsMultiPart = false,
    bool requiresAuthorization = true,
    Map<String, dynamic>? queryParameters,
    bool setContentType = true,
  });
  Future<Response<dynamic>?> deleteRequest({
    String baseUrl = "",
    Map<String, String>? optionalHeaders,
    Map<String, dynamic>? data,
    required String path,
    bool showDialog = false,
    bool requiresAuthorization = true,
  });

  Future<Response<dynamic>?> patchRequest({
    String baseUrl = "",
    Map<String, String>? optionalHeaders,
    dynamic data,
    required String path,
    bool showDialog = false,
    bool contentTypeIsMultiPart = false,
    bool requiresAuthorization = true,
  });

  Future<Response?> putRequest({
    String baseUrl = "",
    Map<String, String>? optionalHeaders,
    dynamic data,
    required String path,
    bool showDialog,
    bool requiresAuthorization,
  });
  Future<Response<dynamic>?> uploadImage({
    String baseUrl = "",
    required String path,
    required File imageFile,
    bool showDialog = false,
    bool requiresAuthorization = true,
    Map<String, String>? optionalHeaders,
  });
}
