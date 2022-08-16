import 'package:hive/hive.dart';

part 'hive_user.g.dart';

@HiveType(typeId: 1)
class HiveUser extends HiveObject {
  @HiveField(0)
  final String userName;
  @HiveField(1)
  final String password;

  HiveUser({
    required this.userName,
    required this.password,
  });
}
