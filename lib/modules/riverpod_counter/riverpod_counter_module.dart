import 'package:flutter_modular/flutter_modular.dart';
import 'package:sigma/modules/riverpod_counter/pages/riverpod_counter_page.dart';
import 'package:sigma/modules/riverpod_counter/pages/riverpod_counter_home_page.dart';

import '../app/sigma_app_modules.dart';

class RiverpodCounterModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          RiverpodCounterModuleRoutes.riverpodCounterHome,
          child: (context, args) => const RiverpodCounterHomePage(),
        ),
        ChildRoute(
          RiverpodCounterModuleRoutes.riverpodCounterPage,
          child: (context, args) => const RiverpodCounterPage(),
        ),
      ];
}

abstract class RiverpodCounterModuleRoutes {
  static const String riverpodCounterHome = "/riverpod_counter_home";
  static const String riverpodCounterPage = "/riverpod_counter_page";

  static String getRoute(String route) {
    return SigmaAppModuleRoute.riverpodCounterModule + route;
  }
}
