import 'animations_module.dart';
import 'models/animation_page.dart';

final List<AnimationPage> animationPagesList = [
    AnimationPage(
    pageRoute:
        AnimationModuleRoute.getRoute(AnimationModuleRoute.heroAnimation),
    pageName: "Hero Animation",
  ),
  AnimationPage(
    pageRoute: AnimationModuleRoute.getRoute(AnimationModuleRoute.addListener),
    pageName: "Add Listener",
  ),
  AnimationPage(
    pageRoute:
        AnimationModuleRoute.getRoute(AnimationModuleRoute.addStatusListener),
    pageName: "Add Status Listener",
  ),
  AnimationPage(
    pageRoute:
        AnimationModuleRoute.getRoute(AnimationModuleRoute.animatedBuilder),
    pageName: "Animated Builder",
  ),

  AnimationPage(
    pageRoute:
        AnimationModuleRoute.getRoute(AnimationModuleRoute.implicitAnimations),
    pageName: "Implicit Animations",
  ),
  AnimationPage(
    pageRoute: AnimationModuleRoute.getRoute(
        AnimationModuleRoute.simultaneousAnimation),
    pageName: "Simultaneous Animation",
  ),
];
