
import 'package:flutter/material.dart';
import 'package:sigma/src/config/flavor_config.dart';

class App extends StatelessWidget {
  final flavorConfig = FlavorConfig.instance;

  // const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sigma",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {},
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text("Sigma"),
              const SizedBox(width: 2),
              Text(
                flavorConfig!.name == "production"
                    ? ""
                    : flavorConfig!.name.toUpperCase(),
                style: const TextStyle(
                  fontSize: 10,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
