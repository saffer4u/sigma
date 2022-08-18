import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sigma/modules/login/cubit/login_cubit.dart';

class LoginHomePage extends StatefulWidget {
  const LoginHomePage({Key? key}) : super(key: key);

  @override
  State<LoginHomePage> createState() => _LoginHomePageState();
}

class _LoginHomePageState extends State<LoginHomePage> {
  final _bloc = Modular.get<LoginCubit>();
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  void initState() {
    _bloc.getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
        ),
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is LoginLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AlreadyLoginState) {
              return const Center(
                child: Text("Yor are alreay Logged In"),
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
                      child: const Text("Login"),
                    ),
                    TextButton(onPressed: () {}, child: const Text("Sign up"))
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
