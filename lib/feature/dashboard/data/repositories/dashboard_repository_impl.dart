import 'package:dartz/dartz.dart';
import 'package:referral_app/core/exceptions/app_exception.dart';
import 'package:referral_app/core/services/storage/secure_storage_service.dart';
import 'package:referral_app/feature/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:referral_app/shared/data/models/wallet_model.dart';
import 'package:referral_app/shared/domain/repositories/referral_repository.dart';
import 'package:referral_app/shared/domain/repositories/reward_trigger_repository.dart';
import 'package:referral_app/shared/domain/repositories/transaction_repository.dart';
import 'package:referral_app/shared/domain/repositories/wallet_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  DashboardRepositoryImpl({
    required SecureStorageService secureStorage,
    required WalletRepository walletRepository,
    required TransactionRepository transactionRepository,
    required ReferralRepository referralRepository,
    required RewardTriggerRepository rewardTriggerRepository,
  }) : _secureStorage = secureStorage,
       _walletRepository = walletRepository,
       _transactionRepository = transactionRepository,
       _referralRepository = referralRepository,
       _rewardTriggerRepository = rewardTriggerRepository;

  final SecureStorageService _secureStorage;

  final WalletRepository _walletRepository;
  final TransactionRepository _transactionRepository;
  final ReferralRepository _referralRepository;
  final RewardTriggerRepository _rewardTriggerRepository;

  @override
  Future<Either<AppException, WalletModel>> getWallet(String userId) async {
    return await _walletRepository.getWallet(userId);
  }
}
