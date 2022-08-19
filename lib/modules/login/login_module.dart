import 'package:flutter_modular/flutter_modular.dart';
import 'package:sigma/modules/login/cubit/login_cubit.dart';
import 'package:sigma/modules/login/cubit/signup_cubit.dart';
import 'package:sigma/modules/login/pages/login_home_page.dart';
import 'package:sigma/modules/login/pages/signup_page.dart';
import 'package:sigma/services/firebase_auth_service.dart';

import '../app/sigma_app_modules.dart';

class LoginModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => LoginCubit(), isSingleton: true),
        Bind((i) => SignupCubit(), isSingleton: true),
        Bind.instance((i) => FirebaseAuthService()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          LoginModuleRoute.loginHome,
          child: (context, args) => const LoginHomePage(),
        ),
        ChildRoute(
          LoginModuleRoute.signUp,
          child: (context, args) => const SignUpPage(),
        ),
      ];
}

abstract class LoginModuleRoute {
  static String loginHome = "/login_home";
  static String signUp = "/sign_up";
  static String getRoute(String route) {
    return SigmaAppModuleRoute.loginModule + route;
  }
}
