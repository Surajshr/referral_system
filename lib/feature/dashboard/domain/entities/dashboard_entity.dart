import 'package:referral_app/shared/data/models/transaction_model.dart';
import 'package:referral_app/shared/data/models/wallet_model.dart';

class DashboardEntity {
  final WalletModel wallet;
  final int successfulReferralCount;
  final String referralCode;
  final List<TransactionModel> transactionHistory;

  DashboardEntity({
    required this.wallet,
    required this.successfulReferralCount,
    required this.referralCode,
    required this.transactionHistory,
  });
}
