import 'package:flutter_modular/flutter_modular.dart';

import '../app/sigma_app_modules.dart';
import 'pages/add_listener.dart';
import 'pages/add_status_listener.dart';
import 'pages/animation_home.dart';
import 'pages/animted_builder.dart';
import 'pages/confetti_animation.dart';
import 'pages/hero_animation.dart';
import 'pages/implicit_animations.dart';
import 'pages/simultaneous_animation.dart';

class AnimationModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          AnimationModuleRoute.animationHome,
          child: (context, args) => const AnimationHome(),
        ),
        ChildRoute(
          AnimationModuleRoute.addListener,
          child: (context, args) => const AddListenerPage(),
        ),
        ChildRoute(
          AnimationModuleRoute.addStatusListener,
          child: (context, args) => const AddStatusListenerPage(),
        ),
        ChildRoute(
          AnimationModuleRoute.animatedBuilder,
          child: (context, args) => const AnimatedBuilderPage(),
        ),
        ChildRoute(
          AnimationModuleRoute.heroAnimation,
          child: (context, args) => const HeroAnimation(),
        ),
        ChildRoute(
          AnimationModuleRoute.implicitAnimations,
          child: (context, args) => const ImplicitAnimations(),
        ),
        ChildRoute(
          AnimationModuleRoute.simultaneousAnimation,
          child: (context, args) => const SimultaneousAnimationPage(),
        ),
        ChildRoute(
          AnimationModuleRoute.confettiAnimation,
          child: (context, args) =>  ConfettiAnimationPage(),
        ),
      ];
}

abstract class AnimationModuleRoute {
  static const String animationHome = '/animation_home';
  static const String addListener = '/add_listener';
  static const String addStatusListener = '/add_status_listener';
  static const String animatedBuilder = '/animated_builder';
  static const String heroAnimation = '/hero_animation';
  static const String implicitAnimations = '/implicit_animations';
  static const String simultaneousAnimation = '/simultaneousAnimation';
  static const String confettiAnimation = '/confetti_animation';

  static String getRoute(String route) {
    return SigmaAppModuleRoute.animations + route;
  }
}
