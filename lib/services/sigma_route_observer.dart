import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

enum RouteAction {
  push,
  pop,
  replace,
}

class SigmaRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  void _sendScreenView({
    required PageRoute<dynamic> route,
    required RouteAction action,
    // Old route will always be null unless acition is PushReplacement,
    PageRoute<dynamic>? oldRoute,
  }) {
    RouteSettings settings = route.settings;

    log("Route : ${settings.name} || Action : ${action.toString().toUpperCase()}");
    if (action == RouteAction.push) {
      trackPageActivities(settings);
    }
  }

  static trackPageActivities(RouteSettings settings) {}

  @override
  void didPush(route, previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      _sendScreenView(
        route: route,
        action: RouteAction.push,
      );
    }
  }

  @override
  void didReplace({newRoute, oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute && oldRoute is PageRoute) {
      _sendScreenView(
        route: newRoute,
        oldRoute: oldRoute,
        action: RouteAction.replace,
      );
    }
  }

  @override
  void didPop(route, previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      _sendScreenView(route: previousRoute, action: RouteAction.pop);
    }
  }
}
