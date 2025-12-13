import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:referral_app/core/services/storage/secure_storage_service.dart';
import 'package:referral_app/feature/auth/signIn/data/repository_impl/signin_repository_impl.dart';
import 'package:referral_app/feature/auth/signIn/domain/repository/signin_repository.dart';
import 'package:referral_app/feature/auth/signIn/domain/usecase/signin_usecase.dart';
import 'package:referral_app/feature/auth/signup/data/repository_impl/signup_repository_impl.dart';
import 'package:referral_app/feature/auth/signup/domain/repository/signup_repository.dart';
import 'package:referral_app/feature/auth/signup/domain/usecase/signup_usecase.dart';

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
  // Register secure storage service
  di.registerLazySingleton<SecureStorageService>(
    () => SecureStorageService(
      const FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
      ),
    ),
  );

  // Register repositories
  _registerRepositories();
}

void _registerRepositories() {
  // Register WalletRepository
  di.registerLazySingleton<WalletRepository>(() => WalletRepositoryImpl());

  // Register TransactionRepository
  di.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(),
  );

  // Register ReferralRepository
  di.registerLazySingleton<ReferralRepository>(() => ReferralRepositoryImpl());

  // Register AuthRepository
  di.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(secureStorage: di<SecureStorageService>()),
  );

  // Register RewardTriggerRepository
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

  // Register SignInUseCase
  di.registerLazySingleton<SignInUseCase>(
    () => SignInUseCase(di<SignInRepository>()),
  );
  // Register SignUpRepository
  di.registerLazySingleton<SignUpRepository>(
    () => SignUpRepositoryImpl(authRepository: di<AuthRepository>()),
  );
  // Register SignUpUseCase
  di.registerLazySingleton<SignUpUseCase>(
    () => SignUpUseCase(di<SignUpRepository>()),
  );
}

void _initNonCriticalDependencies() {
  // Register external services here
  // Example: Analytics, Crash reporting, etc.
}

void reset() {
  di.reset();
}
