// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    TransactionModel(
      amount: (json['amount'] as num?)?.toDouble(),
      name: json['name'] as String?,
      time:
          json['time'] == null ? null : DateTime.parse(json['time'] as String),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'amount': instance.amount,
      'time': instance.time?.toIso8601String(),
      'id': instance.id,
    };
