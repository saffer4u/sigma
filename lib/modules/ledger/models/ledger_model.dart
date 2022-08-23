import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ledger_model.g.dart';

@JsonSerializable()
class LedgerModel extends Equatable {
  final int version;
  final String name;
  final String description;
  final DateTime creationTime;
  final DateTime editTime;

  const LedgerModel({
    this.version = 1,
    required this.name,
    required this.description,
    required this.creationTime,
    required this.editTime,
  });

  factory LedgerModel.fromJson(Map<String, dynamic> json) =>
      _$LedgerModelFromJson(json);

  Map<String, dynamic> toJson() => _$LedgerModelToJson(this);

  @override
  List<Object?> get props => [creationTime, name, description];
}
