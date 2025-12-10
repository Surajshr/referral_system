// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'referral_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReferralModel {

 String get id;@JsonKey(name: 'referrer_id') String get referrerId;@JsonKey(name: 'referee_id') String get refereeId; ReferralStatus get status;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'completed_at') DateTime? get completedAt;
/// Create a copy of ReferralModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReferralModelCopyWith<ReferralModel> get copyWith => _$ReferralModelCopyWithImpl<ReferralModel>(this as ReferralModel, _$identity);

  /// Serializes this ReferralModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReferralModel&&(identical(other.id, id) || other.id == id)&&(identical(other.referrerId, referrerId) || other.referrerId == referrerId)&&(identical(other.refereeId, refereeId) || other.refereeId == refereeId)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,referrerId,refereeId,status,createdAt,completedAt);

@override
String toString() {
  return 'ReferralModel(id: $id, referrerId: $referrerId, refereeId: $refereeId, status: $status, createdAt: $createdAt, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class $ReferralModelCopyWith<$Res>  {
  factory $ReferralModelCopyWith(ReferralModel value, $Res Function(ReferralModel) _then) = _$ReferralModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'referrer_id') String referrerId,@JsonKey(name: 'referee_id') String refereeId, ReferralStatus status,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'completed_at') DateTime? completedAt
});




}
/// @nodoc
class _$ReferralModelCopyWithImpl<$Res>
    implements $ReferralModelCopyWith<$Res> {
  _$ReferralModelCopyWithImpl(this._self, this._then);

  final ReferralModel _self;
  final $Res Function(ReferralModel) _then;

/// Create a copy of ReferralModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? referrerId = null,Object? refereeId = null,Object? status = null,Object? createdAt = null,Object? completedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,referrerId: null == referrerId ? _self.referrerId : referrerId // ignore: cast_nullable_to_non_nullable
as String,refereeId: null == refereeId ? _self.refereeId : refereeId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReferralStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReferralModel].
extension ReferralModelPatterns on ReferralModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReferralModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReferralModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReferralModel value)  $default,){
final _that = this;
switch (_that) {
case _ReferralModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReferralModel value)?  $default,){
final _that = this;
switch (_that) {
case _ReferralModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'referrer_id')  String referrerId, @JsonKey(name: 'referee_id')  String refereeId,  ReferralStatus status, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'completed_at')  DateTime? completedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReferralModel() when $default != null:
return $default(_that.id,_that.referrerId,_that.refereeId,_that.status,_that.createdAt,_that.completedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'referrer_id')  String referrerId, @JsonKey(name: 'referee_id')  String refereeId,  ReferralStatus status, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'completed_at')  DateTime? completedAt)  $default,) {final _that = this;
switch (_that) {
case _ReferralModel():
return $default(_that.id,_that.referrerId,_that.refereeId,_that.status,_that.createdAt,_that.completedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'referrer_id')  String referrerId, @JsonKey(name: 'referee_id')  String refereeId,  ReferralStatus status, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'completed_at')  DateTime? completedAt)?  $default,) {final _that = this;
switch (_that) {
case _ReferralModel() when $default != null:
return $default(_that.id,_that.referrerId,_that.refereeId,_that.status,_that.createdAt,_that.completedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReferralModel implements ReferralModel {
  const _ReferralModel({required this.id, @JsonKey(name: 'referrer_id') required this.referrerId, @JsonKey(name: 'referee_id') required this.refereeId, required this.status, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'completed_at') this.completedAt});
  factory _ReferralModel.fromJson(Map<String, dynamic> json) => _$ReferralModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'referrer_id') final  String referrerId;
@override@JsonKey(name: 'referee_id') final  String refereeId;
@override final  ReferralStatus status;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'completed_at') final  DateTime? completedAt;

/// Create a copy of ReferralModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReferralModelCopyWith<_ReferralModel> get copyWith => __$ReferralModelCopyWithImpl<_ReferralModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReferralModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReferralModel&&(identical(other.id, id) || other.id == id)&&(identical(other.referrerId, referrerId) || other.referrerId == referrerId)&&(identical(other.refereeId, refereeId) || other.refereeId == refereeId)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,referrerId,refereeId,status,createdAt,completedAt);

@override
String toString() {
  return 'ReferralModel(id: $id, referrerId: $referrerId, refereeId: $refereeId, status: $status, createdAt: $createdAt, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class _$ReferralModelCopyWith<$Res> implements $ReferralModelCopyWith<$Res> {
  factory _$ReferralModelCopyWith(_ReferralModel value, $Res Function(_ReferralModel) _then) = __$ReferralModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'referrer_id') String referrerId,@JsonKey(name: 'referee_id') String refereeId, ReferralStatus status,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'completed_at') DateTime? completedAt
});




}
/// @nodoc
class __$ReferralModelCopyWithImpl<$Res>
    implements _$ReferralModelCopyWith<$Res> {
  __$ReferralModelCopyWithImpl(this._self, this._then);

  final _ReferralModel _self;
  final $Res Function(_ReferralModel) _then;

/// Create a copy of ReferralModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? referrerId = null,Object? refereeId = null,Object? status = null,Object? createdAt = null,Object? completedAt = freezed,}) {
  return _then(_ReferralModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,referrerId: null == referrerId ? _self.referrerId : referrerId // ignore: cast_nullable_to_non_nullable
as String,refereeId: null == refereeId ? _self.refereeId : refereeId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReferralStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
