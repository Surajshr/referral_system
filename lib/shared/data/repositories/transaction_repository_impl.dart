import 'dart:developer' as developer;

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:referral_app/core/exceptions/app_exception.dart';
import 'package:referral_app/core/services/supabase/supabase_service.dart';
import 'package:referral_app/core/utils/exception_handler.dart';
import 'package:referral_app/shared/data/models/transaction_model.dart';
import 'package:referral_app/shared/domain/repositories/transaction_repository.dart';
import 'package:referral_app/shared/domain/repositories/wallet_repository.dart';
import 'package:uuid/uuid.dart';

/// Implementation of TransactionRepository using Supabase
class TransactionRepositoryImpl implements TransactionRepository {
  TransactionRepositoryImpl({required WalletRepository walletRepository})
    : _walletRepository = walletRepository;

  final WalletRepository _walletRepository;
  static const _uuid = Uuid();
  @override
  Future<Either<AppException, TransactionModel>> insertTransaction({
    required String userId,
    required double amount,
    required TransactionType type,
    String? referralId,
    String? description,
    required String
    transactionToUserEmail, // the email of the user who is receiving the transaction
  }) async {
    try {
      // Validate inputs
      final validationResult = _validateTransactionInputs(
        amount: amount,
        userId: userId,
        transactionToUserEmail: transactionToUserEmail,
      );
      if (validationResult != null) {
        return Left(validationResult);
      }

      // Get recipient ID
      final recipientResult = await _getRecipientId(transactionToUserEmail);
      final recipientId = await recipientResult.fold(
        (error) async => null,
        (id) async => id,
      );

      if (recipientId == null) {
        return recipientResult.fold(
          (error) => Left(error),
          (_) => throw Exception(),
        );
      }

      // Validate self-transfer
      if (recipientId == userId) {
        return const Left(ValidationException('Cannot send money to yourself'));
      }

      // Check sender's wallet balance
      final balanceCheck = await _validateSenderBalance(userId, amount);
      if (balanceCheck.isLeft()) {
        return balanceCheck.fold(
          (error) => Left(error),
          (_) => throw Exception(),
        );
      }

      // Insert transaction record
      final transaction = await _insertTransactionRecord(
        userId: userId,
        recipientId: recipientId,
        amount: amount,
        type: type,
        referralId: referralId,
        description: description,
      );

      // Update wallet balances
      final walletUpdateResult = await _updateWalletBalances(
        senderId: userId,
        receiverId: recipientId,
        amount: amount,
      );

      if (walletUpdateResult.isLeft()) {
        // Wallet update failed
        //- transaction record exists but wallets not updated
        developer.log(
          'Transaction inserted but wallet update failed',
          name: 'TransactionRepository',
          error: walletUpdateResult.fold((l) => l, (_) => throw Exception()),
          level: 1000,
        );
        // Return transaction but log the issue
        return Right(transaction);
      }

      return Right(transaction);
    } catch (e, s) {
      developer.log(
        'Failed to insert transaction',
        name: 'TransactionRepository',
        error: e,
        stackTrace: s,
        level: 1000,
      );
      return Left(ExceptionHandler.handle(e));
    }
  }

  /// Validates transaction input parameters
  AppException? _validateTransactionInputs({
    required double amount,
    required String userId,
    required String transactionToUserEmail,
  }) {
    if (amount <= 0) {
      return const ValidationException('Amount must be greater than 0');
    }
    if (transactionToUserEmail.isEmpty) {
      return const ValidationException('Recipient email is required');
    }
    return null;
  }

  /// Gets recipient user ID from email
  Future<Either<AppException, String>> _getRecipientId(String email) async {
    try {
      final recipientData = await SupabaseService.from(
        'users',
      ).select('id').eq('email', email).maybeSingle();

      if (recipientData == null) {
        return const Left(
          NotFoundException('Recipient email not found in our system'),
        );
      }

      return Right(recipientData['id'] as String);
    } catch (e, s) {
      developer.log(
        'Failed to get recipient ID',
        name: 'TransactionRepository',
        error: e,
        stackTrace: s,
        level: 1000,
      );
      return Left(ExceptionHandler.handle(e));
    }
  }

  /// Validates sender has sufficient balance
  Future<Either<AppException, Unit>> _validateSenderBalance(
    String userId,
    double amount,
  ) async {
    try {
      final walletData = await SupabaseService.from(
        'wallet',
      ).select('balance').eq('user_id', userId).maybeSingle();

      if (walletData == null) {
        return const Left(
          NotFoundException('Wallet not found. Please contact support'),
        );
      }

      final balance = (walletData['balance'] as num).toDouble();
      if (balance < amount) {
        return Left(
          ValidationException(
            'Insufficient balance. Available: \$${balance.toStringAsFixed(2)}',
          ),
        );
      }

      return const Right(unit);
    } catch (e, s) {
      developer.log(
        'Failed to validate sender balance',
        name: 'TransactionRepository',
        error: e,
        stackTrace: s,
        level: 1000,
      );
      return Left(ExceptionHandler.handle(e));
    }
  }

  /// Inserts transaction record into database
  Future<TransactionModel> _insertTransactionRecord({
    required String userId,
    required String recipientId,
    required double amount,
    required TransactionType type,
    String? referralId,
    String? description,
  }) async {
    final transactionId = _uuid.v4();
    final insertData = <String, dynamic>{
      'id': transactionId,
      'user_id': userId,
      'amount': amount,
      'type': type.value,
      'transaction_to_id': recipientId,
    };

    if (referralId != null) {
      insertData['referral_id'] = referralId;
    }

    if (description != null) {
      insertData['description'] = description;
    }

    final data = await SupabaseService.from(
      'transactions',
    ).insert(insertData).select().single();

    return TransactionModel.fromJson(data);
  }

  /// Updates wallet balances for sender and receiver
  Future<Either<AppException, Unit>> _updateWalletBalances({
    required String senderId,
    required String receiverId,
    required double amount,
  }) async {
    // Debit from sender's wallet
    final debitResult = await _walletRepository.debitWallet(
      userId: senderId,
      amount: amount,
    );

    if (debitResult.isLeft()) {
      return debitResult.fold((error) => Left(error), (_) => throw Exception());
    }

    // Credit to receiver's wallet
    final creditResult = await _walletRepository.creditWallet(
      userId: receiverId,
      amount: amount,
      transactionType: TransactionType.transaction,
    );

    if (creditResult.isLeft()) {
      // Rollback: credit back to sender
      await _walletRepository.creditWallet(
        userId: senderId,
        amount: amount,
        transactionType: TransactionType.refund,
      );

      return creditResult.fold(
        (error) => Left(error),
        (_) => throw Exception(),
      );
    }

    return const Right(unit);
  }

  @override
  Future<Either<AppException, List<TransactionModel>>> getTransactionHistory(
    String userId, {
    int? limit,
    int? offset,
  }) async {
    try {
      var query = SupabaseService.from(
        'transactions',
      ).select().eq('user_id', userId).order('created_at', ascending: false);

      if (limit != null) {
        query = query.limit(limit);
      }

      if (offset != null) {
        query = query.range(offset, offset + (limit ?? 10) - 1);
      }

      final data = await query;

      final transactions = (data as List)
          .map(
            (json) => TransactionModel.fromJson(json as Map<String, dynamic>),
          )
          .toList();

      return Right(transactions);
    } catch (e, s) {
      developer.log(
        'Failed to get transaction history',
        name: 'TransactionRepository',
        error: e,
        stackTrace: s,
        level: 1000,
      );
      return Left(ExceptionHandler.handle(kDebugMode ? e : Exception()));
    }
  }

  @override
  Future<Either<AppException, TransactionModel>> getTransactionById(
    String transactionId,
  ) async {
    try {
      final data = await SupabaseService.from(
        'transactions',
      ).select().eq('id', transactionId).single();

      final transaction = TransactionModel.fromJson(data);
      return Right(transaction);
    } catch (e, s) {
      developer.log(
        'Failed to get transaction by ID',
        name: 'TransactionRepository',
        error: e,
        stackTrace: s,
        level: 1000,
      );
      return Left(ExceptionHandler.handle(e));
    }
  }

  @override
  Future<Either<AppException, List<TransactionModel>>> getTransactionsByType({
    required String userId,
    required TransactionType type,
  }) async {
    try {
      final data = await SupabaseService.from('transactions')
          .select()
          .eq('user_id', userId)
          .eq('type', type.value)
          .order('created_at', ascending: false);

      final transactions = (data as List)
          .map(
            (json) => TransactionModel.fromJson(json as Map<String, dynamic>),
          )
          .toList();

      return Right(transactions);
    } catch (e, s) {
      developer.log(
        'Failed to get transactions by type',
        name: 'TransactionRepository',
        error: e,
        stackTrace: s,
        level: 1000,
      );
      return Left(ExceptionHandler.handle(e));
    }
  }

  @override
  Future<Either<AppException, double>> getTotalReferralEarnings(
    String userId,
  ) async {
    try {
      final data = await SupabaseService.from('transactions')
          .select('amount')
          .eq('user_id', userId)
          .or(
            'type.eq.${TransactionType.referralReward.value},'
            'type.eq.${TransactionType.firstTransactionReward.value}',
          );

      double total = 0.0;
      for (final item in data as List) {
        total += (item['amount'] as num).toDouble();
      }

      return Right(total);
    } catch (e, s) {
      developer.log(
        'Failed to get total referral earnings',
        name: 'TransactionRepository',
        error: e,
        stackTrace: s,
        level: 1000,
      );
      return Left(ExceptionHandler.handle(e));
    }
  }

  @override
  Future<Either<AppException, bool>> isFirstTransaction(String userId) async {
    try {
      // Fetch up to 2 transactions to check count efficiently
      // Only need to know if there's exactly 1 transaction
      final transactions = await SupabaseService.from(
        'transactions',
      ).select('id').eq('user_id', userId).limit(2);

      final count = (transactions as List).length;

      // Return true only if there's exactly one transaction
      return Right(count == 1);
    } catch (e, s) {
      developer.log(
        'Failed to check if first transaction',
        name: 'TransactionRepository',
        error: e,
        stackTrace: s,
        level: 1000,
      );
      return Left(ExceptionHandler.handle(e));
    }
  }
}
