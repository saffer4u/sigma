part of 'hive_todos_bloc.dart';

abstract class HiveTodosEvent extends Equatable {
  const HiveTodosEvent();
}

class LoadTodosEvent extends HiveTodosEvent {
  final String userName;

  const LoadTodosEvent({required this.userName});
  @override
  List<Object?> get props => [userName];
}
