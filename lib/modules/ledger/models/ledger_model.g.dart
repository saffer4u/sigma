// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ledger_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LedgerModel _$LedgerModelFromJson(Map<String, dynamic> json) => LedgerModel(
      name: json['name'] as String,
      description: json['description'] as String,
      creationTime: DateTime.parse(json['creationTime'] as String),
    );

Map<String, dynamic> _$LedgerModelToJson(LedgerModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'creationTime': instance.creationTime.toIso8601String(),
    };
