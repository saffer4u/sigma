import 'package:flutter_modular/flutter_modular.dart';
import 'package:sigma/modules/ledger/ledger_module.dart';
import 'package:sigma/modules/login/cubit/login_cubit.dart';
import 'package:sigma/modules/login/login_module.dart';
import 'package:sigma/modules/todo_hive/todo_hive_module.dart';
import 'package:sigma/services/database_service.dart';

import '../../services/firebase_auth_service.dart';
import '../../src/config/flavor_config.dart';
import '../animations/animations_module.dart';
import '../random/random_module.dart';
import 'bloc/home_bloc.dart';
import 'pages/home_page.dart';

class SigmaAppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => LoginCubit(), isLazy: true, isSingleton: true),
        Bind.singleton((i) => FlavorConfig.instance!),
        Bind.singleton((i) => HomeBloc()),
        Bind((i) => FirebaseAuthService(), isSingleton: true),
        Bind((i) => DatabaseService(), isSingleton: true),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute("/", child: (context, args) => const HomePage()),
        ModuleRoute(SigmaAppModuleRoute.animations, module: AnimationModule()),
        ModuleRoute(SigmaAppModuleRoute.random, module: RandomModule()),
        ModuleRoute(SigmaAppModuleRoute.todoHive, module: TodoHiveModule()),
        ModuleRoute(SigmaAppModuleRoute.loginModule, module: LoginModule()),
        ModuleRoute(SigmaAppModuleRoute.ledgerModule, module: LedgerModule()),
      ];
}

class SigmaAppModuleRoute {
  static const String animations = '/animations_module';
  static const String random = "/random_module";
  static const String todoHive = "/todo_hive";
  static const String loginModule = "/login_module";
  static const String ledgerModule = "/ledger_module";
}
