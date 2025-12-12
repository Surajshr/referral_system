// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'referral_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReferralModel _$ReferralModelFromJson(Map<String, dynamic> json) =>
    _ReferralModel(
      id: json['id'] as String,
      referrerId: json['referrer_id'] as String,
      refereeId: json['referee_id'] as String,
      status: $enumDecode(_$ReferralStatusEnumMap, json['status']),
      createdAt: DateTime.parse(json['created_at'] as String),
      completedAt: json['completed_at'] == null
          ? null
          : DateTime.parse(json['completed_at'] as String),
    );

Map<String, dynamic> _$ReferralModelToJson(_ReferralModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'referrer_id': instance.referrerId,
      'referee_id': instance.refereeId,
      'status': _$ReferralStatusEnumMap[instance.status]!,
      'created_at': instance.createdAt.toIso8601String(),
      'completed_at': instance.completedAt?.toIso8601String(),
    };

const _$ReferralStatusEnumMap = {
  ReferralStatus.pending: 'pending',
  ReferralStatus.successful: 'successful',
  ReferralStatus.failed: 'failed',
};
