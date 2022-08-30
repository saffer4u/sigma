import 'package:sigma/modules/ledger/ledger_module.dart';
import 'package:sigma/modules/login/login_module.dart';
import 'package:sigma/modules/riverpod_counter/riverpod_counter_module.dart';
import 'package:sigma/modules/todo_hive/todo_hive_module.dart';

import '../animations/animations_module.dart';
import '../random/random_module.dart';
import 'models/module_info.dart';

final List<ModuleInfo> modulesList = [
  ModuleInfo(
    moduleName: "Animations Module",
    moduleRoute:
        AnimationModuleRoute.getRoute(AnimationModuleRoute.animationHome),
  ),
  ModuleInfo(
    moduleName: "Random Module",
    moduleRoute: RandomModuleRoute.getRoute(RandomModuleRoute.randomHome),
  ),
  ModuleInfo(
    moduleName: "Todo Hive Module",
    moduleRoute:
        TodoHiveModuleRoutes.getRoute(TodoHiveModuleRoutes.todoHiveHome),
  ),
  ModuleInfo(
    moduleName: "Login Module",
    moduleRoute: LoginModuleRoute.getRoute(LoginModuleRoute.loginHome),
  ),
  ModuleInfo(
    moduleName: "Ledger Module",
    moduleRoute: LedgerModuleRoutes.getRoute(LedgerModuleRoutes.ladgerHome),
  ),
  ModuleInfo(
    moduleName: "Counter with RiverPod",
    moduleRoute: RiverpodCounterModuleRoutes.getRoute(
      RiverpodCounterModuleRoutes.riverpodCounterHome,
    ),
  ),
];
