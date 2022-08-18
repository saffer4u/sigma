import 'package:flutter_modular/flutter_modular.dart';
import 'package:sigma/modules/login/cubit/login_cubit.dart';
import 'package:sigma/modules/login/pages/login_home_page.dart';
import 'package:sigma/services/firebase_auth_service.dart';

import '../app/sigma_app_modules.dart';

class LoginModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => LoginCubit(), isSingleton: true),
        Bind(
          (i) => FirebaseAuthService(),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          LoginModuleRoute.loginHome,
          child: (context, args) => LoginHomePage(),
        ),
      ];
}

abstract class LoginModuleRoute {
  static String loginHome = "/login_home";
  static String getRoute(String route) {
    return SigmaAppModuleRoute.loginModule + route;
  }
}
