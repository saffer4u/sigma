import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sigma/modules/todo_hive/services/hive_todo.dart';

import '../blocs/todo_bloc/hive_todos_bloc.dart';

class HiveTodosPage extends StatelessWidget {
  final String userName;
  const HiveTodosPage({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("TODOs")),
      body: BlocProvider(
        create: (context) => HiveTodosBloc(Modular.get<HiveTodoService>())
          ..add(LoadTodosEvent(userName: userName)),
        child: BlocBuilder<HiveTodosBloc, HiveTodosState>(
          builder: (context, state) {
            if (state is TodosLoadedState) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.tasks[index].task),
                    trailing: Checkbox(
                      value: state.tasks[index].completed,
                      onChanged: (bool? value) {},
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: state.tasks.length,
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
