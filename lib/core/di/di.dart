import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:referral_app/core/services/storage/secure_storage_service.dart';
import 'package:referral_app/feature/auth/signIn/data/repository_impl/signin_repository_impl.dart';
import 'package:referral_app/feature/auth/signIn/domain/repository/signin_repository.dart';
import 'package:referral_app/feature/auth/signIn/domain/usecase/signin_usecase.dart';
import 'package:referral_app/feature/auth/signup/data/repository_impl/signup_repository_impl.dart';
import 'package:referral_app/feature/auth/signup/domain/repository/signup_repository.dart';
import 'package:referral_app/feature/auth/signup/domain/usecase/signup_usecase.dart';
import 'package:referral_app/feature/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:referral_app/feature/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:referral_app/feature/dashboard/domain/usecases/dashboard_usecase.dart';
import 'package:referral_app/feature/transaction/data/repositories/transaction_ui_repository_impl.dart';
import 'package:referral_app/feature/transaction/domain/repositories/transaction_ui_repository.dart';
import 'package:referral_app/feature/transaction/domain/usecases/transaction/transaction_usecase.dart';

import 'package:referral_app/shared/data/repositories/auth_repository_impl.dart';
import 'package:referral_app/shared/data/repositories/referral_repository_impl.dart';
import 'package:referral_app/shared/data/repositories/reward_trigger_repository_impl.dart';
import 'package:referral_app/shared/data/repositories/transaction_repository_impl.dart';
import 'package:referral_app/shared/data/repositories/wallet_repository_impl.dart';
import 'package:referral_app/shared/domain/repositories/auth_repository.dart';
import 'package:referral_app/shared/domain/repositories/referral_repository.dart';
import 'package:referral_app/shared/domain/repositories/reward_trigger_repository.dart';
import 'package:referral_app/shared/domain/repositories/transaction_repository.dart';
import 'package:referral_app/shared/domain/repositories/wallet_repository.dart';

final GetIt di = GetIt.instance;

Future<void> initDependencies() async {
  await _initCriticalDependencies();
  _initNonCriticalDependencies();
}

Future<void> _initCriticalDependencies() async {
  di.registerLazySingleton<SecureStorageService>(
    () => SecureStorageService(
      const FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
      ),
    ),
  );
}

void _initNonCriticalDependencies() {
  di.registerLazySingleton<WalletRepository>(() => WalletRepositoryImpl());

  di.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(walletRepository: di<WalletRepository>()),
  );

  di.registerLazySingleton<ReferralRepository>(() => ReferralRepositoryImpl());

  di.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(secureStorage: di<SecureStorageService>()),
  );
  di.registerLazySingleton<RewardTriggerRepository>(
    () => RewardTriggerRepositoryImpl(
      walletRepository: di<WalletRepository>(),
      transactionRepository: di<TransactionRepository>(),
      referralRepository: di<ReferralRepository>(),
    ),
  );

  di.registerLazySingleton<SignInRepository>(
    () => SignInRepositoryImpl(authRepository: di<AuthRepository>()),
  );

  di.registerLazySingleton<SignInUseCase>(
    () => SignInUseCase(di<SignInRepository>()),
  );

  di.registerLazySingleton<SignUpRepository>(
    () => SignUpRepositoryImpl(authRepository: di<AuthRepository>()),
  );

  di.registerLazySingleton<SignUpUseCase>(
    () => SignUpUseCase(di<SignUpRepository>()),
  );
  di.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(
      walletRepository: di<WalletRepository>(),
      referralRepository: di<ReferralRepository>(),
      transactionRepository: di<TransactionRepository>(),
    ),
  );
  di.registerLazySingleton<DashboardUsecase>(
    () => DashboardUsecase(di<DashboardRepository>()),
  );
  di.registerLazySingleton<TransactionUIRepository>(
    () => TransactionUIRepositoryImpl(
      transactionRepository: di<TransactionRepository>(),
      rewardTriggerRepository: di<RewardTriggerRepository>(),
    ),
  );
  di.registerLazySingleton<TransactionUsecase>(
    () => TransactionUsecase(
      di<TransactionUIRepository>(),
      di<RewardTriggerRepository>(),
    ),
  );
}

void reset() {
  di.reset();
}
