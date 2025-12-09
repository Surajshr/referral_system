// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SignInModel _$SignInModelFromJson(Map<String, dynamic> json) => _SignInModel(
  message: json['message'] as String,
  data: SignInDataEntity.fromJson(json['data'] as Map<String, dynamic>),
  meta: SignInMeta.fromJson(json['meta'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SignInModelToJson(_SignInModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
      'meta': instance.meta,
    };

_SignInDataEntity _$SignInDataEntityFromJson(Map<String, dynamic> json) =>
    _SignInDataEntity(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );

Map<String, dynamic> _$SignInDataEntityToJson(_SignInDataEntity instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };

_SignInMeta _$SignInMetaFromJson(Map<String, dynamic> json) => _SignInMeta(
  api: SignInApiInfo.fromJson(json['api'] as Map<String, dynamic>),
  lang: SignInLangInfo.fromJson(json['lang'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SignInMetaToJson(_SignInMeta instance) =>
    <String, dynamic>{'api': instance.api, 'lang': instance.lang};

_SignInApiInfo _$SignInApiInfoFromJson(Map<String, dynamic> json) =>
    _SignInApiInfo(version: json['version'] as String);

Map<String, dynamic> _$SignInApiInfoToJson(_SignInApiInfo instance) =>
    <String, dynamic>{'version': instance.version};

_SignInLangInfo _$SignInLangInfoFromJson(Map<String, dynamic> json) =>
    _SignInLangInfo(version: json['version'] as String);

Map<String, dynamic> _$SignInLangInfoToJson(_SignInLangInfo instance) =>
    <String, dynamic>{'version': instance.version};
