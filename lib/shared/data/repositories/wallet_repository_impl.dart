import 'dart:developer' as developer;

import 'package:dartz/dartz.dart';
import 'package:referral_app/core/exceptions/app_exception.dart';
import 'package:referral_app/core/services/supabase/supabase_service.dart';
import 'package:referral_app/core/utils/exception_handler.dart';
import 'package:referral_app/shared/data/models/wallet_model.dart';
import 'package:referral_app/shared/domain/repositories/wallet_repository.dart';

/// Implementation of WalletRepository using Supabase
class WalletRepositoryImpl implements WalletRepository {
  @override
  Future<Either<AppException, WalletModel>> getWallet(String userId) async {
    try {
      final data = await SupabaseService.from(
        'wallet',
      ).select().eq('user_id', userId).single();

      final wallet = WalletModel.fromJson(data);
      return Right(wallet);
    } catch (e, s) {
      developer.log(
        'Failed to get wallet',
        name: 'WalletRepository',
        error: e,
        stackTrace: s,
        level: 1000,
      );
      return Left(ExceptionHandler.handle(e));
    }
  }

  @override
  Future<Either<AppException, double>> getWalletBalance(String userId) async {
    try {
      final data = await SupabaseService.from(
        'wallet',
      ).select('balance').eq('user_id', userId).single();

      final balance = (data['balance'] as num).toDouble();
      return Right(balance);
    } catch (e, s) {
      developer.log(
        'Failed to get wallet balance',
        name: 'WalletRepository',
        error: e,
        stackTrace: s,
        level: 1000,
      );
      return Left(ExceptionHandler.handle(e));
    }
  }

  @override
  Future<Either<AppException, WalletModel>> creditWallet({
    required String userId,
    required double amount,
  }) async {
    try {
      if (amount <= 0) {
        return const Left(ValidationException('Amount must be greater than 0'));
      }

      // Get current balance
      final currentWallet = await getWallet(userId);
      return currentWallet.fold((error) => Left(error), (wallet) async {
        final newBalance = wallet.balance + amount;

        // Update wallet balance
        final data = await SupabaseService.from('wallet')
            .update({'balance': newBalance})
            .eq('user_id', userId)
            .select()
            .single();

        final updatedWallet = WalletModel.fromJson(data);
        return Right(updatedWallet);
      });
    } catch (e, s) {
      developer.log(
        'Failed to credit wallet',
        name: 'WalletRepository',
        error: e,
        stackTrace: s,
        level: 1000,
      );
      return Left(ExceptionHandler.handle(e));
    }
  }

  @override
  Future<Either<AppException, WalletModel>> debitWallet({
    required String userId,
    required double amount,
  }) async {
    try {
      if (amount <= 0) {
        return const Left(ValidationException('Amount must be greater than 0'));
      }

      // Get current balance
      final currentWallet = await getWallet(userId);
      return currentWallet.fold((error) => Left(error), (wallet) async {
        // Check if sufficient balance
        if (wallet.balance < amount) {
          return const Left(ValidationException('Insufficient balance'));
        }

        final newBalance = wallet.balance - amount;

        // Update wallet balance
        final data = await SupabaseService.from('wallet')
            .update({'balance': newBalance})
            .eq('user_id', userId)
            .select()
            .single();

        final updatedWallet = WalletModel.fromJson(data);
        return Right(updatedWallet);
      });
    } catch (e, s) {
      developer.log(
        'Failed to debit wallet',
        name: 'WalletRepository',
        error: e,
        stackTrace: s,
        level: 1000,
      );
      return Left(ExceptionHandler.handle(e));
    }
  }

  @override
  Future<Either<AppException, WalletModel>> createWallet(String userId) async {
    try {
      final data = await SupabaseService.from(
        'wallet',
      ).insert({'user_id': userId, 'balance': 0.0}).select().single();

      final wallet = WalletModel.fromJson(data);
      return Right(wallet);
    } catch (e, s) {
      developer.log(
        'Failed to create wallet',
        name: 'WalletRepository',
        error: e,
        stackTrace: s,
        level: 1000,
      );
      return Left(ExceptionHandler.handle(e));
    }
  }
}
