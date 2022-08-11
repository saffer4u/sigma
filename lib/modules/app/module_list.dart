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
];
