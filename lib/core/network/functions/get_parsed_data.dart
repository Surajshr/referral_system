import 'package:referral_app/core/network/failure/failure_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

List<int> successStatusCodes = [200, 201, 202, 204];

Future<Either<T, Failure>> getParsedData<T>(
  Response? response,
  T Function(Map<String, dynamic>) fromJson,
) async {
  if (response != null && successStatusCodes.contains(response.statusCode)) {
    // PrintUtil.printLog(
    //   tag: 'response data on parsing',
    //   message: '${response.data}',
    // );
    //handle success here
    if (response.data is Map<String, dynamic>) {
      try {
        return Left(fromJson(response.data as Map<String, dynamic>));
      } catch (e) {
        print('Error parsing data: $e');
        return Right(Failure.fromJson(response.data as Map<String, dynamic>));
      }
    } else if (response.statusCode == 204 || response.statusCode == 201) {
      // status code 204 means success but no response data
      return Left(fromJson(response.data as Map<String, dynamic>));
    } else {
      return Right(Failure.fromJson(response.data as Map<String, dynamic>));
    }
  } else {
    Map<String, dynamic>? failedRespData;
    try {
      failedRespData = response?.data as Map<String, dynamic>?;
    } catch (e) {
      print("Could not parse backend response as map");
      failedRespData = {};
    }

    return Right(Failure.fromJson(failedRespData ?? {}));
  }
}
