import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sigma/modules/login/cubit/signup_cubit.dart';
import 'package:sigma/modules/login/login_module.dart';

import '../../../utils/helpers.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _bloc = Modular.get<SignupCubit>();
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Sign Up"),
        ),
        body: BlocConsumer<SignupCubit, SignupState>(
          listener: (context, state) {
            if (state is SignupFaild) {
              _showErrorMessage(message: state.message);
            }
          },
          builder: (context, state) {
            if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SignupSuccess) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Your account has been created"),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => Modular.to.pop(),
                      child: const Text("Home"),
                    ),
                  ],
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: "Email"),
                    ),
                    TextFormField(
                      controller: passwordController,
                      decoration: const InputDecoration(labelText: "Password"),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        _bloc.signUp(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                      },
                      child: const Text("Sign Up"),
                    ),
                    TextButton(
                        onPressed: () => Modular.to.pushReplacementNamed(
                              LoginModuleRoute.getRoute(
                                  LoginModuleRoute.loginHome),
                            ),
                        child: const Text("Login"))
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

void _showErrorMessage({
  required String message,
}) {
  Alerts.showSnackBar(message);
}
