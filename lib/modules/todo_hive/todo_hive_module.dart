import 'package:flutter_modular/flutter_modular.dart';
import 'package:sigma/modules/todo_hive/pages/hive_todos.dart';
import 'package:sigma/modules/todo_hive/services/hive_authentication.dart';
import 'package:sigma/modules/todo_hive/services/hive_todo.dart';

import '../app/sigma_app_modules.dart';
import 'pages/todo_hive_home.dart';

class TodoHiveModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => HiveAuthenticationService()),
        Bind.singleton((i) => HiveTodoService()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          TodoHiveModuleRoutes.todoHiveHome,
          child: (context, args) => TodoHiveHome(),
        ),
        ChildRoute(
          TodoHiveModuleRoutes.todosPage,
          child: (context, args) => HiveTodosPage(
            userName: args.data['user'],
          ),
        ),
      ];
}

abstract class TodoHiveModuleRoutes {
  static const todoHiveHome = '/todo_hive_home';
  static const todosPage = '/todos_page';
  static String getRoute(String route) {
    return SigmaAppModuleRoute.todoHive + route;
  }
}
