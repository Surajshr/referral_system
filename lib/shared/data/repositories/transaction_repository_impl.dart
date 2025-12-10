import 'dart:developer' as developer;

import 'package:dartz/dartz.dart';
import 'package:referral_app/core/exceptions/app_exception.dart';
import 'package:referral_app/core/services/supabase/supabase_service.dart';
import 'package:referral_app/core/utils/exception_handler.dart';
import 'package:referral_app/shared/data/models/transaction_model.dart';
import 'package:referral_app/shared/domain/repositories/transaction_repository.dart';

/// Implementation of TransactionRepository using Supabase
class TransactionRepositoryImpl implements TransactionRepository {
  @override
  Future<Either<AppException, TransactionModel>> insertTransaction({
    required String userId,
    required double amount,
    required TransactionType type,
    String? referralId,
    String? description,
  }) async {
    try {
      if (amount <= 0) {
        return const Left(ValidationException('Amount must be greater than 0'));
      }

      final data = await SupabaseService.from('transactions')
          .insert({
            'user_id': userId,
            'amount': amount,
            'type': type.value,
            'referral_id': referralId,
            'description': description,
          })
          .select()
          .single();

      final transaction = TransactionModel.fromJson(data);
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
      return Left(ExceptionHandler.handle(e));
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
}
