import 'package:referral_app/shared/data/models/transaction_model.dart';

class TransactionEntity {
  final String userId;
  final double amount;
  final TransactionType type;
  final String? referralId;
  final String? description;
  final String transactionToUserEmail;

  TransactionEntity({
    required this.userId,
    required this.amount,
    required this.type,
    required this.referralId,
    required this.description,
    required this.transactionToUserEmail,
  });
}
