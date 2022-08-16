import 'package:hive/hive.dart';
import 'package:sigma/modules/todo_hive/model/hive_task.dart';

class HiveTodoService {
  late Box<HiveTask> _tasks;
  Future<void> init() async {
    Hive.registerAdapter(HiveTaskAdapter());
    _tasks = await Hive.openBox<HiveTask>("hiveTasks");
    await _tasks.add(HiveTask(
      user: "aftab",
      task: "This is a task",
      completed: true,
    ));
  }

  List<HiveTask> getHiveTasks({
    required String userName,
  }) {
    final tasks = _tasks.values.where((element) => element.user == userName);
    return tasks.toList();
  }

  void addTask({
    required final String task,
    required final String userName,
  }) {
    _tasks.add(HiveTask(
      user: userName,
      task: task,
      completed: false,
    ));
  }

  Future<void> removeHiveTask(
      {required String task, required String userName}) async {
    final taskToRemove = _tasks.values.firstWhere(
      (element) => element.task == task && element.user == userName,
    );
    await taskToRemove.delete();
  }

  Future<void> updateTask({
    required String task,
    required String userName,
    bool? completed,
  }) async {
    final taskToEdit = _tasks.values.firstWhere(
        (element) => element.task == task && element.user == userName);

    final index = taskToEdit.key as int;
    await _tasks.put(
        index,
        HiveTask(
          user: userName,
          task: task,
          completed: completed ?? taskToEdit.completed,
        ));
  }
}
