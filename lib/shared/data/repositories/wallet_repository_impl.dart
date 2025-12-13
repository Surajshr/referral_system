import 'dart:developer' as developer;

import 'package:dartz/dartz.dart';
import 'package:referral_app/core/constants/app_constants.dart';
import 'package:referral_app/core/exceptions/app_exception.dart';
import 'package:referral_app/core/services/supabase/supabase_service.dart';
import 'package:referral_app/core/utils/exception_handler.dart';
import 'package:referral_app/shared/data/models/transaction_model.dart';
import 'package:referral_app/shared/data/models/wallet_model.dart';
import 'package:referral_app/shared/domain/repositories/wallet_repository.dart';
import 'package:uuid/uuid.dart';

/// Implementation of WalletRepository using Supabase
class WalletRepositoryImpl implements WalletRepository {
  static const _uuid = Uuid();
  @override
  Future<Either<AppException, WalletModel>> getWallet(String userId) async {
    try {
      developer.log(
        'Getting wallet for userId: $userId',
        name: 'WalletRepository',
      );

      // Query wallet - try with explicit column selection first
      final data = await SupabaseService.from('wallet')
          .select('user_id, balance, created_at, updated_at')
          .eq('user_id', userId)
          .maybeSingle();

      developer.log('Wallet query result: $data', name: 'WalletRepository');

      if (data == null) {
        // Wallet doesn't exist, create one
        developer.log(
          'Wallet not found for user, creating new wallet',
          name: 'WalletRepository',
        );
        return await createWallet(userId);
      }

      // Validate that user_id exists in the response
      if (data['user_id'] == null) {
        developer.log(
          'Wallet data missing user_id field. Data keys: ${data.keys}, Full data: $data',
          name: 'WalletRepository',
          level: 1000,
        );
        // Try to delete by any means possible and recreate
        try {
          // Try deleting by user_id first
          await SupabaseService.from('wallet').delete().eq('user_id', userId);
        } catch (e) {
          // If that fails, the wallet might be corrupted - log and continue
          developer.log(
            'Could not delete corrupted wallet: $e',
            name: 'WalletRepository',
            level: 1000,
          );
        }
        return await createWallet(userId);
      }

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
    TransactionType? transactionType,
    String? referralId,
    String? description,
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
            .select('user_id, balance, created_at, updated_at')
            .single();

        final updatedWallet = WalletModel.fromJson(data);

        // Insert transaction record if transaction type is provided
        if (transactionType != null) {
          await _insertWalletTransaction(
            userId: userId,
            amount: amount,
            type: transactionType,
            referralId: referralId,
            description: description ?? 'Wallet credit',
          );
        }

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
    TransactionType? transactionType,
    String? referralId,
    String? description,
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
            .select('user_id, balance, created_at, updated_at')
            .single();

        final updatedWallet = WalletModel.fromJson(data);

        // Insert transaction record if transaction type is provided
        if (transactionType != null) {
          await _insertWalletTransaction(
            userId: userId,
            amount: amount,
            type: transactionType,
            referralId: referralId,
            description: description ?? 'Wallet debit',
          );
        }

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
      final data = await SupabaseService.from('wallet')
          .insert({'user_id': userId, 'balance': AppConstants.openingBalance})
          .select('user_id, balance, created_at, updated_at')
          .single();

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

  /// Inserts a transaction record for wallet operations
  /// This is used for internal wallet credit/debit operations
  Future<void> _insertWalletTransaction({
    required String userId,
    required double amount,
    required TransactionType type,
    String? referralId,
    String? description,
  }) async {
    try {
      final transactionId = _uuid.v4();
      final insertData = <String, dynamic>{
        'id': transactionId,
        'user_id': userId,
        'amount': amount,
        'type': type.value,
        'transaction_to_id': userId, // Self-transaction for wallet operations
      };

      if (referralId != null) {
        insertData['referral_id'] = referralId;
      }

      if (description != null) {
        insertData['description'] = description;
      }

      await SupabaseService.from('transactions').insert(insertData);
    } catch (e, s) {
      // Log error but don't fail the wallet operation
      developer.log(
        'Failed to insert wallet transaction record',
        name: 'WalletRepository',
        error: e,
        stackTrace: s,
        level: 1000,
      );
    }
  }
}
