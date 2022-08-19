import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ledger_model.g.dart';

@JsonSerializable()
class LedgerModel extends Equatable {
  final String name;
  final String description;
  final DateTime creationTime;

  const LedgerModel({
    required this.name,
    required this.description,
    required this.creationTime,
  });

  @override
  List<Object?> get props => [creationTime, name, description];
}
