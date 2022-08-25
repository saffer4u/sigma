import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../login/login_module.dart';

class LoggedOutPage extends StatelessWidget {
  const LoggedOutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("You are not Logged In"),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () => Modular.to.pushReplacementNamed(
                  LoginModuleRoute.getRoute(LoginModuleRoute.loginHome)),
              child: const Text("LogIn")),
        ],
      )),
    );
  }
}
