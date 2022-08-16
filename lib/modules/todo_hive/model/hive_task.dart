import 'package:hive/hive.dart';
part 'hive_task.g.dart';

@HiveType(typeId: 2)
class HiveTask extends HiveObject {
  @HiveField(0)
  final String user;
  @HiveField(1)
  final String task;
  @HiveField(2)
  final bool completed;

  HiveTask({
    required this.user,
    required this.task,
    required this.completed,
  });
}
