import 'package:freezed_annotation/freezed_annotation.dart';

part 'referral_model.freezed.dart';
part 'referral_model.g.dart';

/// Referral status enum
enum ReferralStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('successful')
  successful,
  @JsonValue('failed')
  failed;

  String get value {
    return switch (this) {
      ReferralStatus.pending => 'pending',
      ReferralStatus.successful => 'successful',
      ReferralStatus.failed => 'failed',
    };
  }
}

/// Referral model representing the referrals table
@freezed
abstract class ReferralModel with _$ReferralModel {
  const factory ReferralModel({
    required String id,
    @JsonKey(name: 'referrer_id') required String referrerId,
    @JsonKey(name: 'referee_id') required String refereeId,
    required ReferralStatus status,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'completed_at') DateTime? completedAt,
  }) = _ReferralModel;

  factory ReferralModel.fromJson(Map<String, dynamic> json) =>
      _$ReferralModelFromJson(json);
}
