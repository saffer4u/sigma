import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sigma/modules/app/sigma_app_modules.dart';
import 'package:sigma/modules/login/login_module.dart';

import '../../../src/config/flavor_config.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_states.dart';
import '../module_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final flavorConfig = Modular.get<FlavorConfig>();

  final _bloc = Modular.get<HomeBloc>();

  @override
  void initState() {
    _bloc.checkUserState();
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
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
          actions: [
            IconButton(
              onPressed: () => Modular.to.pushNamed(
                  LoginModuleRoute.getRoute(LoginModuleRoute.loginHome)),
              icon: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is UserLoggedInState) {
                    return const Icon(
                      Icons.circle,
                      color: Colors.green,
                    );
                  } else if (state is UserLoggedOutState) {
                    return const Icon(
                      Icons.circle,
                      color: Colors.red,
                    );
                  }

                  return const Icon(Icons.circle);
                },
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7),
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
