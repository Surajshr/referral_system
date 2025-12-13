class FieldErrorResponseModel {
  List<Errors>? errors;

  FieldErrorResponseModel({this.errors});

  FieldErrorResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['errors'] != null) {
      errors = <Errors>[];
      json['errors'].forEach((v) {
        errors!.add(Errors.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (errors != null) {
      data['errors'] = errors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Errors {
  String? message;
  String? field;
  List<String>? messages;

  Errors({this.message, this.field, this.messages});

  Errors.fromJson(Map<String, dynamic> json) {
    field = json['field'] as String?;

    // Handle both single message string and list of messages
    if (json['message'] is List) {
      messages = (json['message'] as List).map((e) => e.toString()).toList();
      // Use the first message as the primary message for backward compatibility
      message = messages?.isNotEmpty == true ? messages!.first : null;
    } else {
      message = json['message'] as String?;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = messages ?? message;
    data['field'] = field;
    return data;
  }
}
