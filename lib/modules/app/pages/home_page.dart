import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../src/config/flavor_config.dart';
import '../bloc/home_bloc.dart';
import '../module_list.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final flavorConfig = Modular.get<FlavorConfig>();
  final _homeBloc = Modular.get<HomeBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text("Sigma"),
            const SizedBox(width: 2),
            Text(
              flavorConfig.name == "production"
                  ? ""
                  : flavorConfig.name.toUpperCase(),
              style: const TextStyle(
                fontSize: 10,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
      body: BlocProvider.value(
        value: _homeBloc,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:10.0,vertical: 7),
          child: ListView.separated(
            itemCount: modulesList.length,
            separatorBuilder: (context, index) =>
                const Divider(thickness: 1, height: 2),
            itemBuilder: (context, index) {
              return ElevatedButton(
                onPressed: () =>
                    Modular.to.pushNamed(modulesList[index].moduleRoute),
                child: Text(modulesList[index].moduleName),
              );
            },
          ),
        ),
      ),
    );
  }
}
