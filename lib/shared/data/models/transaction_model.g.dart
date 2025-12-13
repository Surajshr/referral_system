// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    _TransactionModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      amount: (json['amount'] as num).toDouble(),
      type: $enumDecode(_$TransactionTypeEnumMap, json['type']),
      createdAt: DateTime.parse(json['created_at'] as String),
      referralId: json['referral_id'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$TransactionModelToJson(_TransactionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'amount': instance.amount,
      'type': _$TransactionTypeEnumMap[instance.type]!,
      'created_at': instance.createdAt.toIso8601String(),
      'referral_id': instance.referralId,
      'description': instance.description,
    };

const _$TransactionTypeEnumMap = {
  TransactionType.referralReward: 'REFERRAL_REWARD',
  TransactionType.firstTransactionReward: 'FIRST_TRANSACTION_REWARD',
  TransactionType.withdrawal: 'WITHDRAWAL',
  TransactionType.refund: 'REFUND',
  TransactionType.transaction: 'TRANSACTION',
};
