import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sigma/modules/todo_hive/model/hive_task.dart';
import 'package:sigma/modules/todo_hive/services/hive_todo.dart';

part 'hive_todos_event.dart';
part 'hive_todos_state.dart';

class HiveTodosBloc extends Bloc<HiveTodosEvent, HiveTodosState> {
  final HiveTodoService _todoService;

  HiveTodosBloc(this._todoService) : super(HiveTodosInitial()) {
    on<LoadTodosEvent>((event, emit) {
      final todos = _todoService.getHiveTasks(userName: event.userName);
    });
  }
}
