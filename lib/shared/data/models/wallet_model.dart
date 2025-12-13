import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_model.freezed.dart';
part 'wallet_model.g.dart';

/// Wallet model representing the wallet table
@freezed
abstract class WalletModel with _$WalletModel {
  const factory WalletModel({
    @JsonKey(name: 'user_id') required String userId,
    required double balance,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _WalletModel;

  factory WalletModel.fromJson(Map<String, dynamic> json) =>
      _$WalletModelFromJson(json);
}
