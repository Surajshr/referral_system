// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TransactionState {

 String get recipient; String get amount; String get note; bool get showNoteField; bool get isLoading; String get selectedQuickAmount; String? get errorMessage; String? get successMessage; EmailFormz get email;
/// Create a copy of TransactionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionStateCopyWith<TransactionState> get copyWith => _$TransactionStateCopyWithImpl<TransactionState>(this as TransactionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionState&&(identical(other.recipient, recipient) || other.recipient == recipient)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.note, note) || other.note == note)&&(identical(other.showNoteField, showNoteField) || other.showNoteField == showNoteField)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.selectedQuickAmount, selectedQuickAmount) || other.selectedQuickAmount == selectedQuickAmount)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage)&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,recipient,amount,note,showNoteField,isLoading,selectedQuickAmount,errorMessage,successMessage,email);

@override
String toString() {
  return 'TransactionState(recipient: $recipient, amount: $amount, note: $note, showNoteField: $showNoteField, isLoading: $isLoading, selectedQuickAmount: $selectedQuickAmount, errorMessage: $errorMessage, successMessage: $successMessage, email: $email)';
}


}

/// @nodoc
abstract mixin class $TransactionStateCopyWith<$Res>  {
  factory $TransactionStateCopyWith(TransactionState value, $Res Function(TransactionState) _then) = _$TransactionStateCopyWithImpl;
@useResult
$Res call({
 String recipient, String amount, String note, bool showNoteField, bool isLoading, String selectedQuickAmount, String? errorMessage, String? successMessage, EmailFormz email
});




}
/// @nodoc
class _$TransactionStateCopyWithImpl<$Res>
    implements $TransactionStateCopyWith<$Res> {
  _$TransactionStateCopyWithImpl(this._self, this._then);

  final TransactionState _self;
  final $Res Function(TransactionState) _then;

/// Create a copy of TransactionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? recipient = null,Object? amount = null,Object? note = null,Object? showNoteField = null,Object? isLoading = null,Object? selectedQuickAmount = null,Object? errorMessage = freezed,Object? successMessage = freezed,Object? email = null,}) {
  return _then(_self.copyWith(
recipient: null == recipient ? _self.recipient : recipient // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,showNoteField: null == showNoteField ? _self.showNoteField : showNoteField // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,selectedQuickAmount: null == selectedQuickAmount ? _self.selectedQuickAmount : selectedQuickAmount // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as EmailFormz,
  ));
}

}


/// Adds pattern-matching-related methods to [TransactionState].
extension TransactionStatePatterns on TransactionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionState value)  $default,){
final _that = this;
switch (_that) {
case _TransactionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionState value)?  $default,){
final _that = this;
switch (_that) {
case _TransactionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String recipient,  String amount,  String note,  bool showNoteField,  bool isLoading,  String selectedQuickAmount,  String? errorMessage,  String? successMessage,  EmailFormz email)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionState() when $default != null:
return $default(_that.recipient,_that.amount,_that.note,_that.showNoteField,_that.isLoading,_that.selectedQuickAmount,_that.errorMessage,_that.successMessage,_that.email);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String recipient,  String amount,  String note,  bool showNoteField,  bool isLoading,  String selectedQuickAmount,  String? errorMessage,  String? successMessage,  EmailFormz email)  $default,) {final _that = this;
switch (_that) {
case _TransactionState():
return $default(_that.recipient,_that.amount,_that.note,_that.showNoteField,_that.isLoading,_that.selectedQuickAmount,_that.errorMessage,_that.successMessage,_that.email);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String recipient,  String amount,  String note,  bool showNoteField,  bool isLoading,  String selectedQuickAmount,  String? errorMessage,  String? successMessage,  EmailFormz email)?  $default,) {final _that = this;
switch (_that) {
case _TransactionState() when $default != null:
return $default(_that.recipient,_that.amount,_that.note,_that.showNoteField,_that.isLoading,_that.selectedQuickAmount,_that.errorMessage,_that.successMessage,_that.email);case _:
  return null;

}
}

}

/// @nodoc


class _TransactionState implements TransactionState {
  const _TransactionState({this.recipient = '', this.amount = '', this.note = '', this.showNoteField = false, this.isLoading = false, this.selectedQuickAmount = '', this.errorMessage, this.successMessage, this.email = const EmailFormz.pure()});
  

@override@JsonKey() final  String recipient;
@override@JsonKey() final  String amount;
@override@JsonKey() final  String note;
@override@JsonKey() final  bool showNoteField;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  String selectedQuickAmount;
@override final  String? errorMessage;
@override final  String? successMessage;
@override@JsonKey() final  EmailFormz email;

/// Create a copy of TransactionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionStateCopyWith<_TransactionState> get copyWith => __$TransactionStateCopyWithImpl<_TransactionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionState&&(identical(other.recipient, recipient) || other.recipient == recipient)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.note, note) || other.note == note)&&(identical(other.showNoteField, showNoteField) || other.showNoteField == showNoteField)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.selectedQuickAmount, selectedQuickAmount) || other.selectedQuickAmount == selectedQuickAmount)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage)&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,recipient,amount,note,showNoteField,isLoading,selectedQuickAmount,errorMessage,successMessage,email);

@override
String toString() {
  return 'TransactionState(recipient: $recipient, amount: $amount, note: $note, showNoteField: $showNoteField, isLoading: $isLoading, selectedQuickAmount: $selectedQuickAmount, errorMessage: $errorMessage, successMessage: $successMessage, email: $email)';
}


}

/// @nodoc
abstract mixin class _$TransactionStateCopyWith<$Res> implements $TransactionStateCopyWith<$Res> {
  factory _$TransactionStateCopyWith(_TransactionState value, $Res Function(_TransactionState) _then) = __$TransactionStateCopyWithImpl;
@override @useResult
$Res call({
 String recipient, String amount, String note, bool showNoteField, bool isLoading, String selectedQuickAmount, String? errorMessage, String? successMessage, EmailFormz email
});




}
/// @nodoc
class __$TransactionStateCopyWithImpl<$Res>
    implements _$TransactionStateCopyWith<$Res> {
  __$TransactionStateCopyWithImpl(this._self, this._then);

  final _TransactionState _self;
  final $Res Function(_TransactionState) _then;

/// Create a copy of TransactionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? recipient = null,Object? amount = null,Object? note = null,Object? showNoteField = null,Object? isLoading = null,Object? selectedQuickAmount = null,Object? errorMessage = freezed,Object? successMessage = freezed,Object? email = null,}) {
  return _then(_TransactionState(
recipient: null == recipient ? _self.recipient : recipient // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,showNoteField: null == showNoteField ? _self.showNoteField : showNoteField // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,selectedQuickAmount: null == selectedQuickAmount ? _self.selectedQuickAmount : selectedQuickAmount // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as EmailFormz,
  ));
}


}

// dart format on
