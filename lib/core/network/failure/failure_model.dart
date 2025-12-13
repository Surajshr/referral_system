import 'package:referral_app/core/constants/string_constants.dart';
import 'package:referral_app/core/network/failure/field_errors_response_model.dart';

class Failure {
  /// Error messages thrown from backend logic part
  String? message;
  int? statusCode;
  String? title;
  String? error;
  int? code;

  /// Error messages thrown from form validators on backend side
  FieldErrorResponseModel? fieldErrors;

  Failure({this.message, this.statusCode, this.title, this.error, this.code});

  Failure.fromJson(Map<String, dynamic> json) {
    print('🔍 Raw JSON Error Data: $json');
    print('🔍 JSON Keys: ${json.keys.toList()}');

    // Handle new error format: {"error": "BAD_REQUEST", "message": "...", "code": 1014, "statusCode": 401}
    if (json.containsKey('error') && json.containsKey('message')) {
      print('✅ Parsing as new error format');
      error = json['error'] as String?;
      message = json['message'] as String?;
      code = json['code'] as int?;
      statusCode = json['statusCode'] as int?;
    }
    // Handle validation errors format: {"message": "...", "errors": [...], "code": 1002, "statusCode": 422}
    else if (json.containsKey('errors') && json['errors'] is List) {
      print('✅ Parsing as validation errors format');
      message = json['message'] as String?;
      code = json['code'] as int?;
      statusCode = json['statusCode'] as int?;
      fieldErrors = FieldErrorResponseModel.fromJson(json);
    }
    // Handle legacy format: {"errors": [{"code": ..., "title": ..., "detail": ...}]}
    else if (json.containsKey('errors') &&
        json['errors'] is List &&
        (json['errors'] as List).isNotEmpty) {
      print('✅ Parsing as legacy format');
      final errorsList = json['errors'] as List;
      if (errorsList.isNotEmpty) {
        final firstError = errorsList[0] as Map<String, dynamic>;
        statusCode = firstError['code'] as int?;
        title = firstError['title'] as String?;
        final detail = firstError['detail'] as String?;
        message = detail ?? StringConstant.defaultErrorMsg;
      }
    }
    // Fallback for any other format
    else {
      print('⚠️ Using fallback parsing');
      message = json['message'] as String? ?? StringConstant.defaultErrorMsg;
      statusCode = json['statusCode'] as int?;
      code = json['code'] as int?;
    }

    print(
      '🔍 Parsed Result - Message: $message, StatusCode: $statusCode, Code: $code, Error: $error',
    );
  }

  /// FYI: Error message can either be in field errors or in the error field.
  /// So this method comes handy to pick a best fitting error message
  String getErrorMsg() {
    // If there are field errors, get the first field error message
    if (fieldErrors?.errors != null && fieldErrors!.errors!.isNotEmpty) {
      final firstFieldError = fieldErrors!.errors!.first;
      if (firstFieldError.message != null &&
          firstFieldError.message!.isNotEmpty) {
        return firstFieldError.message!;
      }
    }

    // Otherwise return the main message or default error message
    return message ?? StringConstant.defaultErrorMsg;
  }
}
