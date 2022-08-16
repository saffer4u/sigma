import 'package:hive/hive.dart';
import 'package:sigma/modules/todo_hive/model/hive_task.dart';
import 'package:sigma/modules/todo_hive/model/hive_user.dart';

class HiveAuthenticationService {
  late Box<HiveUser> _user;
  Future<void> init() async {
    Hive.registerAdapter(HiveUserAdapter());
    _user = await Hive.openBox<HiveUser>("userBox");
    await _user.add(HiveUser(userName: "aftab", password: "1234"));
  }

  Future<String?> authenticateUser({
    required final String userName,
    required final String password,
  }) async {
    final success = await _user.values.any(
      (element) => element.userName == userName && element.password == password,
    );
    if (success) {
      return userName;
    } else {
      return null;
    }
  }
}
