import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sigma/modules/todo_hive/pages/hive_todos.dart';
import 'package:sigma/modules/todo_hive/services/hive_authentication.dart';
import 'package:sigma/modules/todo_hive/services/hive_todo.dart';
import 'package:sigma/modules/todo_hive/todo_hive_module.dart';

import '../blocs/home_bloc/hive_home_bloc.dart';

class TodoHiveHome extends StatelessWidget {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  TodoHiveHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo Hive"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: BlocProvider(
            create: (context) => HiveHomeBloc(
                Modular.get<HiveAuthenticationService>(),
                Modular.get<HiveTodoService>())
              ..add(RegisterServiceEvent()),
            child: BlocConsumer<HiveHomeBloc, HiveHomeState>(
              listener: (context, state) {
                if (state is HiveSuccessfulLoginState) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return HiveTodosPage(userName: state.userName);
                    },
                  ));
                }
              },
              builder: (context, state) {
                if (state is HiveHomeInitial) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: userNameController,
                        decoration:
                            const InputDecoration(labelText: "User Name"),
                      ),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration:
                            const InputDecoration(labelText: "Password"),
                      ),
                      ElevatedButton(
                        onPressed: () => BlocProvider.of<HiveHomeBloc>(context)
                            .add(LoginEvent(
                          password: passwordController.text,
                          userName: userNameController.text,
                        )),
                        child: const Text("LogIn"),
                      ),
                    ],
                  );
                }
                return Container(
                  color: Colors.red,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
