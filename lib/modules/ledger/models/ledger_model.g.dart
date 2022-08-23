// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ledger_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LedgerModel _$LedgerModelFromJson(Map<String, dynamic> json) => LedgerModel(
      version: json['version'] as int? ?? 1,
      name: json['name'] as String,
      description: json['description'] as String,
      creationTime: DateTime.parse(json['creationTime'] as String),
      editTime: DateTime.parse(json['editTime'] as String),
    );

Map<String, dynamic> _$LedgerModelToJson(LedgerModel instance) =>
    <String, dynamic>{
      'version': instance.version,
      'name': instance.name,
      'description': instance.description,
      'creationTime': instance.creationTime.toIso8601String(),
      'editTime': instance.editTime.toIso8601String(),
    };
