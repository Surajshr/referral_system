// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signin_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SignInModel {

 String get message; SignInDataEntity get data; SignInMeta get meta;
/// Create a copy of SignInModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignInModelCopyWith<SignInModel> get copyWith => _$SignInModelCopyWithImpl<SignInModel>(this as SignInModel, _$identity);

  /// Serializes this SignInModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignInModel&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data)&&(identical(other.meta, meta) || other.meta == meta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,data,meta);

@override
String toString() {
  return 'SignInModel(message: $message, data: $data, meta: $meta)';
}


}

/// @nodoc
abstract mixin class $SignInModelCopyWith<$Res>  {
  factory $SignInModelCopyWith(SignInModel value, $Res Function(SignInModel) _then) = _$SignInModelCopyWithImpl;
@useResult
$Res call({
 String message, SignInDataEntity data, SignInMeta meta
});


$SignInDataEntityCopyWith<$Res> get data;$SignInMetaCopyWith<$Res> get meta;

}
/// @nodoc
class _$SignInModelCopyWithImpl<$Res>
    implements $SignInModelCopyWith<$Res> {
  _$SignInModelCopyWithImpl(this._self, this._then);

  final SignInModel _self;
  final $Res Function(SignInModel) _then;

/// Create a copy of SignInModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,Object? data = null,Object? meta = null,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as SignInDataEntity,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as SignInMeta,
  ));
}
/// Create a copy of SignInModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SignInDataEntityCopyWith<$Res> get data {
  
  return $SignInDataEntityCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}/// Create a copy of SignInModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SignInMetaCopyWith<$Res> get meta {
  
  return $SignInMetaCopyWith<$Res>(_self.meta, (value) {
    return _then(_self.copyWith(meta: value));
  });
}
}


/// Adds pattern-matching-related methods to [SignInModel].
extension SignInModelPatterns on SignInModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignInModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignInModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignInModel value)  $default,){
final _that = this;
switch (_that) {
case _SignInModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignInModel value)?  $default,){
final _that = this;
switch (_that) {
case _SignInModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String message,  SignInDataEntity data,  SignInMeta meta)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignInModel() when $default != null:
return $default(_that.message,_that.data,_that.meta);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String message,  SignInDataEntity data,  SignInMeta meta)  $default,) {final _that = this;
switch (_that) {
case _SignInModel():
return $default(_that.message,_that.data,_that.meta);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String message,  SignInDataEntity data,  SignInMeta meta)?  $default,) {final _that = this;
switch (_that) {
case _SignInModel() when $default != null:
return $default(_that.message,_that.data,_that.meta);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SignInModel implements SignInModel {
   _SignInModel({required this.message, required this.data, required this.meta});
  factory _SignInModel.fromJson(Map<String, dynamic> json) => _$SignInModelFromJson(json);

@override final  String message;
@override final  SignInDataEntity data;
@override final  SignInMeta meta;

/// Create a copy of SignInModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignInModelCopyWith<_SignInModel> get copyWith => __$SignInModelCopyWithImpl<_SignInModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignInModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignInModel&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data)&&(identical(other.meta, meta) || other.meta == meta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,data,meta);

@override
String toString() {
  return 'SignInModel(message: $message, data: $data, meta: $meta)';
}


}

/// @nodoc
abstract mixin class _$SignInModelCopyWith<$Res> implements $SignInModelCopyWith<$Res> {
  factory _$SignInModelCopyWith(_SignInModel value, $Res Function(_SignInModel) _then) = __$SignInModelCopyWithImpl;
@override @useResult
$Res call({
 String message, SignInDataEntity data, SignInMeta meta
});


@override $SignInDataEntityCopyWith<$Res> get data;@override $SignInMetaCopyWith<$Res> get meta;

}
/// @nodoc
class __$SignInModelCopyWithImpl<$Res>
    implements _$SignInModelCopyWith<$Res> {
  __$SignInModelCopyWithImpl(this._self, this._then);

  final _SignInModel _self;
  final $Res Function(_SignInModel) _then;

/// Create a copy of SignInModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? data = null,Object? meta = null,}) {
  return _then(_SignInModel(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as SignInDataEntity,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as SignInMeta,
  ));
}

/// Create a copy of SignInModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SignInDataEntityCopyWith<$Res> get data {
  
  return $SignInDataEntityCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}/// Create a copy of SignInModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SignInMetaCopyWith<$Res> get meta {
  
  return $SignInMetaCopyWith<$Res>(_self.meta, (value) {
    return _then(_self.copyWith(meta: value));
  });
}
}


/// @nodoc
mixin _$SignInDataEntity {

 String get accessToken; String get refreshToken;
/// Create a copy of SignInDataEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignInDataEntityCopyWith<SignInDataEntity> get copyWith => _$SignInDataEntityCopyWithImpl<SignInDataEntity>(this as SignInDataEntity, _$identity);

  /// Serializes this SignInDataEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignInDataEntity&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,refreshToken);

@override
String toString() {
  return 'SignInDataEntity(accessToken: $accessToken, refreshToken: $refreshToken)';
}


}

/// @nodoc
abstract mixin class $SignInDataEntityCopyWith<$Res>  {
  factory $SignInDataEntityCopyWith(SignInDataEntity value, $Res Function(SignInDataEntity) _then) = _$SignInDataEntityCopyWithImpl;
@useResult
$Res call({
 String accessToken, String refreshToken
});




}
/// @nodoc
class _$SignInDataEntityCopyWithImpl<$Res>
    implements $SignInDataEntityCopyWith<$Res> {
  _$SignInDataEntityCopyWithImpl(this._self, this._then);

  final SignInDataEntity _self;
  final $Res Function(SignInDataEntity) _then;

/// Create a copy of SignInDataEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accessToken = null,Object? refreshToken = null,}) {
  return _then(_self.copyWith(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SignInDataEntity].
extension SignInDataEntityPatterns on SignInDataEntity {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignInDataEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignInDataEntity() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignInDataEntity value)  $default,){
final _that = this;
switch (_that) {
case _SignInDataEntity():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignInDataEntity value)?  $default,){
final _that = this;
switch (_that) {
case _SignInDataEntity() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String accessToken,  String refreshToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignInDataEntity() when $default != null:
return $default(_that.accessToken,_that.refreshToken);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String accessToken,  String refreshToken)  $default,) {final _that = this;
switch (_that) {
case _SignInDataEntity():
return $default(_that.accessToken,_that.refreshToken);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String accessToken,  String refreshToken)?  $default,) {final _that = this;
switch (_that) {
case _SignInDataEntity() when $default != null:
return $default(_that.accessToken,_that.refreshToken);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SignInDataEntity implements SignInDataEntity {
   _SignInDataEntity({required this.accessToken, required this.refreshToken});
  factory _SignInDataEntity.fromJson(Map<String, dynamic> json) => _$SignInDataEntityFromJson(json);

@override final  String accessToken;
@override final  String refreshToken;

/// Create a copy of SignInDataEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignInDataEntityCopyWith<_SignInDataEntity> get copyWith => __$SignInDataEntityCopyWithImpl<_SignInDataEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignInDataEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignInDataEntity&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,refreshToken);

@override
String toString() {
  return 'SignInDataEntity(accessToken: $accessToken, refreshToken: $refreshToken)';
}


}

/// @nodoc
abstract mixin class _$SignInDataEntityCopyWith<$Res> implements $SignInDataEntityCopyWith<$Res> {
  factory _$SignInDataEntityCopyWith(_SignInDataEntity value, $Res Function(_SignInDataEntity) _then) = __$SignInDataEntityCopyWithImpl;
@override @useResult
$Res call({
 String accessToken, String refreshToken
});




}
/// @nodoc
class __$SignInDataEntityCopyWithImpl<$Res>
    implements _$SignInDataEntityCopyWith<$Res> {
  __$SignInDataEntityCopyWithImpl(this._self, this._then);

  final _SignInDataEntity _self;
  final $Res Function(_SignInDataEntity) _then;

/// Create a copy of SignInDataEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accessToken = null,Object? refreshToken = null,}) {
  return _then(_SignInDataEntity(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SignInMeta {

 SignInApiInfo get api; SignInLangInfo get lang;
/// Create a copy of SignInMeta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignInMetaCopyWith<SignInMeta> get copyWith => _$SignInMetaCopyWithImpl<SignInMeta>(this as SignInMeta, _$identity);

  /// Serializes this SignInMeta to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignInMeta&&(identical(other.api, api) || other.api == api)&&(identical(other.lang, lang) || other.lang == lang));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,api,lang);

@override
String toString() {
  return 'SignInMeta(api: $api, lang: $lang)';
}


}

/// @nodoc
abstract mixin class $SignInMetaCopyWith<$Res>  {
  factory $SignInMetaCopyWith(SignInMeta value, $Res Function(SignInMeta) _then) = _$SignInMetaCopyWithImpl;
@useResult
$Res call({
 SignInApiInfo api, SignInLangInfo lang
});


$SignInApiInfoCopyWith<$Res> get api;$SignInLangInfoCopyWith<$Res> get lang;

}
/// @nodoc
class _$SignInMetaCopyWithImpl<$Res>
    implements $SignInMetaCopyWith<$Res> {
  _$SignInMetaCopyWithImpl(this._self, this._then);

  final SignInMeta _self;
  final $Res Function(SignInMeta) _then;

/// Create a copy of SignInMeta
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? api = null,Object? lang = null,}) {
  return _then(_self.copyWith(
api: null == api ? _self.api : api // ignore: cast_nullable_to_non_nullable
as SignInApiInfo,lang: null == lang ? _self.lang : lang // ignore: cast_nullable_to_non_nullable
as SignInLangInfo,
  ));
}
/// Create a copy of SignInMeta
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SignInApiInfoCopyWith<$Res> get api {
  
  return $SignInApiInfoCopyWith<$Res>(_self.api, (value) {
    return _then(_self.copyWith(api: value));
  });
}/// Create a copy of SignInMeta
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SignInLangInfoCopyWith<$Res> get lang {
  
  return $SignInLangInfoCopyWith<$Res>(_self.lang, (value) {
    return _then(_self.copyWith(lang: value));
  });
}
}


/// Adds pattern-matching-related methods to [SignInMeta].
extension SignInMetaPatterns on SignInMeta {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignInMeta value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignInMeta() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignInMeta value)  $default,){
final _that = this;
switch (_that) {
case _SignInMeta():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignInMeta value)?  $default,){
final _that = this;
switch (_that) {
case _SignInMeta() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SignInApiInfo api,  SignInLangInfo lang)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignInMeta() when $default != null:
return $default(_that.api,_that.lang);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SignInApiInfo api,  SignInLangInfo lang)  $default,) {final _that = this;
switch (_that) {
case _SignInMeta():
return $default(_that.api,_that.lang);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SignInApiInfo api,  SignInLangInfo lang)?  $default,) {final _that = this;
switch (_that) {
case _SignInMeta() when $default != null:
return $default(_that.api,_that.lang);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SignInMeta implements SignInMeta {
   _SignInMeta({required this.api, required this.lang});
  factory _SignInMeta.fromJson(Map<String, dynamic> json) => _$SignInMetaFromJson(json);

@override final  SignInApiInfo api;
@override final  SignInLangInfo lang;

/// Create a copy of SignInMeta
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignInMetaCopyWith<_SignInMeta> get copyWith => __$SignInMetaCopyWithImpl<_SignInMeta>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignInMetaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignInMeta&&(identical(other.api, api) || other.api == api)&&(identical(other.lang, lang) || other.lang == lang));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,api,lang);

@override
String toString() {
  return 'SignInMeta(api: $api, lang: $lang)';
}


}

/// @nodoc
abstract mixin class _$SignInMetaCopyWith<$Res> implements $SignInMetaCopyWith<$Res> {
  factory _$SignInMetaCopyWith(_SignInMeta value, $Res Function(_SignInMeta) _then) = __$SignInMetaCopyWithImpl;
@override @useResult
$Res call({
 SignInApiInfo api, SignInLangInfo lang
});


@override $SignInApiInfoCopyWith<$Res> get api;@override $SignInLangInfoCopyWith<$Res> get lang;

}
/// @nodoc
class __$SignInMetaCopyWithImpl<$Res>
    implements _$SignInMetaCopyWith<$Res> {
  __$SignInMetaCopyWithImpl(this._self, this._then);

  final _SignInMeta _self;
  final $Res Function(_SignInMeta) _then;

/// Create a copy of SignInMeta
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? api = null,Object? lang = null,}) {
  return _then(_SignInMeta(
api: null == api ? _self.api : api // ignore: cast_nullable_to_non_nullable
as SignInApiInfo,lang: null == lang ? _self.lang : lang // ignore: cast_nullable_to_non_nullable
as SignInLangInfo,
  ));
}

/// Create a copy of SignInMeta
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SignInApiInfoCopyWith<$Res> get api {
  
  return $SignInApiInfoCopyWith<$Res>(_self.api, (value) {
    return _then(_self.copyWith(api: value));
  });
}/// Create a copy of SignInMeta
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SignInLangInfoCopyWith<$Res> get lang {
  
  return $SignInLangInfoCopyWith<$Res>(_self.lang, (value) {
    return _then(_self.copyWith(lang: value));
  });
}
}


/// @nodoc
mixin _$SignInApiInfo {

 String get version;
/// Create a copy of SignInApiInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignInApiInfoCopyWith<SignInApiInfo> get copyWith => _$SignInApiInfoCopyWithImpl<SignInApiInfo>(this as SignInApiInfo, _$identity);

  /// Serializes this SignInApiInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignInApiInfo&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version);

@override
String toString() {
  return 'SignInApiInfo(version: $version)';
}


}

/// @nodoc
abstract mixin class $SignInApiInfoCopyWith<$Res>  {
  factory $SignInApiInfoCopyWith(SignInApiInfo value, $Res Function(SignInApiInfo) _then) = _$SignInApiInfoCopyWithImpl;
@useResult
$Res call({
 String version
});




}
/// @nodoc
class _$SignInApiInfoCopyWithImpl<$Res>
    implements $SignInApiInfoCopyWith<$Res> {
  _$SignInApiInfoCopyWithImpl(this._self, this._then);

  final SignInApiInfo _self;
  final $Res Function(SignInApiInfo) _then;

/// Create a copy of SignInApiInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? version = null,}) {
  return _then(_self.copyWith(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SignInApiInfo].
extension SignInApiInfoPatterns on SignInApiInfo {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignInApiInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignInApiInfo() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignInApiInfo value)  $default,){
final _that = this;
switch (_that) {
case _SignInApiInfo():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignInApiInfo value)?  $default,){
final _that = this;
switch (_that) {
case _SignInApiInfo() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String version)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignInApiInfo() when $default != null:
return $default(_that.version);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String version)  $default,) {final _that = this;
switch (_that) {
case _SignInApiInfo():
return $default(_that.version);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String version)?  $default,) {final _that = this;
switch (_that) {
case _SignInApiInfo() when $default != null:
return $default(_that.version);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SignInApiInfo implements SignInApiInfo {
   _SignInApiInfo({required this.version});
  factory _SignInApiInfo.fromJson(Map<String, dynamic> json) => _$SignInApiInfoFromJson(json);

@override final  String version;

/// Create a copy of SignInApiInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignInApiInfoCopyWith<_SignInApiInfo> get copyWith => __$SignInApiInfoCopyWithImpl<_SignInApiInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignInApiInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignInApiInfo&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version);

@override
String toString() {
  return 'SignInApiInfo(version: $version)';
}


}

/// @nodoc
abstract mixin class _$SignInApiInfoCopyWith<$Res> implements $SignInApiInfoCopyWith<$Res> {
  factory _$SignInApiInfoCopyWith(_SignInApiInfo value, $Res Function(_SignInApiInfo) _then) = __$SignInApiInfoCopyWithImpl;
@override @useResult
$Res call({
 String version
});




}
/// @nodoc
class __$SignInApiInfoCopyWithImpl<$Res>
    implements _$SignInApiInfoCopyWith<$Res> {
  __$SignInApiInfoCopyWithImpl(this._self, this._then);

  final _SignInApiInfo _self;
  final $Res Function(_SignInApiInfo) _then;

/// Create a copy of SignInApiInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? version = null,}) {
  return _then(_SignInApiInfo(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SignInLangInfo {

 String get version;
/// Create a copy of SignInLangInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignInLangInfoCopyWith<SignInLangInfo> get copyWith => _$SignInLangInfoCopyWithImpl<SignInLangInfo>(this as SignInLangInfo, _$identity);

  /// Serializes this SignInLangInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignInLangInfo&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version);

@override
String toString() {
  return 'SignInLangInfo(version: $version)';
}


}

/// @nodoc
abstract mixin class $SignInLangInfoCopyWith<$Res>  {
  factory $SignInLangInfoCopyWith(SignInLangInfo value, $Res Function(SignInLangInfo) _then) = _$SignInLangInfoCopyWithImpl;
@useResult
$Res call({
 String version
});




}
/// @nodoc
class _$SignInLangInfoCopyWithImpl<$Res>
    implements $SignInLangInfoCopyWith<$Res> {
  _$SignInLangInfoCopyWithImpl(this._self, this._then);

  final SignInLangInfo _self;
  final $Res Function(SignInLangInfo) _then;

/// Create a copy of SignInLangInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? version = null,}) {
  return _then(_self.copyWith(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SignInLangInfo].
extension SignInLangInfoPatterns on SignInLangInfo {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignInLangInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignInLangInfo() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignInLangInfo value)  $default,){
final _that = this;
switch (_that) {
case _SignInLangInfo():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignInLangInfo value)?  $default,){
final _that = this;
switch (_that) {
case _SignInLangInfo() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String version)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignInLangInfo() when $default != null:
return $default(_that.version);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String version)  $default,) {final _that = this;
switch (_that) {
case _SignInLangInfo():
return $default(_that.version);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String version)?  $default,) {final _that = this;
switch (_that) {
case _SignInLangInfo() when $default != null:
return $default(_that.version);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SignInLangInfo implements SignInLangInfo {
   _SignInLangInfo({required this.version});
  factory _SignInLangInfo.fromJson(Map<String, dynamic> json) => _$SignInLangInfoFromJson(json);

@override final  String version;

/// Create a copy of SignInLangInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignInLangInfoCopyWith<_SignInLangInfo> get copyWith => __$SignInLangInfoCopyWithImpl<_SignInLangInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignInLangInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignInLangInfo&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version);

@override
String toString() {
  return 'SignInLangInfo(version: $version)';
}


}

/// @nodoc
abstract mixin class _$SignInLangInfoCopyWith<$Res> implements $SignInLangInfoCopyWith<$Res> {
  factory _$SignInLangInfoCopyWith(_SignInLangInfo value, $Res Function(_SignInLangInfo) _then) = __$SignInLangInfoCopyWithImpl;
@override @useResult
$Res call({
 String version
});




}
/// @nodoc
class __$SignInLangInfoCopyWithImpl<$Res>
    implements _$SignInLangInfoCopyWith<$Res> {
  __$SignInLangInfoCopyWithImpl(this._self, this._then);

  final _SignInLangInfo _self;
  final $Res Function(_SignInLangInfo) _then;

/// Create a copy of SignInLangInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? version = null,}) {
  return _then(_SignInLangInfo(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
