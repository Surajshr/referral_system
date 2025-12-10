import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

/// Transaction type enum
enum TransactionType {
  @JsonValue('REFERRAL_REWARD')
  referralReward,
  @JsonValue('FIRST_TRANSACTION_REWARD')
  firstTransactionReward,
  @JsonValue('WITHDRAWAL')
  withdrawal,
  @JsonValue('REFUND')
  refund;

  String get value {
    return switch (this) {
      TransactionType.referralReward => 'REFERRAL_REWARD',
      TransactionType.firstTransactionReward => 'FIRST_TRANSACTION_REWARD',
      TransactionType.withdrawal => 'WITHDRAWAL',
      TransactionType.refund => 'REFUND',
    };
  }
}

/// Transaction model representing the transactions table
@freezed
abstract class TransactionModel with _$TransactionModel {
  const factory TransactionModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    required double amount,
    required TransactionType type,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'referral_id') String? referralId,
    String? description,
  }) = _TransactionModel;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);
}
