import 'package:freezed_annotation/freezed_annotation.dart';

part 'signin_model.freezed.dart';
part 'signin_model.g.dart';

@freezed
abstract class SignInModel with _$SignInModel {
  factory SignInModel({
    required String message,
    required SignInDataEntity data,
    required SignInMeta meta,
  }) = _SignInModel;

  factory SignInModel.fromJson(Map<String, dynamic> json) =>
      _$SignInModelFromJson(json);
}

@freezed
abstract class SignInDataEntity with _$SignInDataEntity {
  factory SignInDataEntity({
    required String accessToken,
    required String refreshToken,
  }) = _SignInDataEntity;

  factory SignInDataEntity.fromJson(Map<String, dynamic> json) =>
      _$SignInDataEntityFromJson(json);
}

@freezed
abstract class SignInMeta with _$SignInMeta {
  factory SignInMeta({
    required SignInApiInfo api,
    required SignInLangInfo lang,
  }) = _SignInMeta;

  factory SignInMeta.fromJson(Map<String, dynamic> json) =>
      _$SignInMetaFromJson(json);
}

@freezed
abstract class SignInApiInfo with _$SignInApiInfo {
  factory SignInApiInfo({required String version}) = _SignInApiInfo;

  factory SignInApiInfo.fromJson(Map<String, dynamic> json) =>
      _$SignInApiInfoFromJson(json);
}

@freezed
abstract class SignInLangInfo with _$SignInLangInfo {
  factory SignInLangInfo({required String version}) = _SignInLangInfo;

  factory SignInLangInfo.fromJson(Map<String, dynamic> json) =>
      _$SignInLangInfoFromJson(json);
}
