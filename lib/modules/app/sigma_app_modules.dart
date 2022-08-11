import 'package:flutter_modular/flutter_modular.dart';

import '../../src/config/flavor_config.dart';
import '../animations/animations_module.dart';
import '../random/random_module.dart';
import 'bloc/home_bloc.dart';
import 'pages/home_page.dart';

class SigmaAppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => FlavorConfig.instance!),
        Bind.singleton((i) => HomeBloc()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute("/", child: (context, args) => HomePage()),
        ModuleRoute(SigmaAppModuleRoute.animations, module: AnimationModule()),
        ModuleRoute(SigmaAppModuleRoute.random, module: RandomModule()),
      ];
}

class SigmaAppModuleRoute {
  static const String animations = '/animations_module';
  static const String random = "/random_module";
}
