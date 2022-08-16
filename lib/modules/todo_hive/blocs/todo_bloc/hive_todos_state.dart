part of 'hive_todos_bloc.dart';

abstract class HiveTodosState extends Equatable {
  const HiveTodosState();
}

class HiveTodosInitial extends HiveTodosState {
  @override
  List<Object?> get props => [];
}

class TodosLoadedState extends HiveTodosState {
  final List<HiveTask> tasks;

  const TodosLoadedState({required this.tasks});

  @override
  List<Object?> get props => [];
}
