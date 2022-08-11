import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../random_pages_list.dart';

class RandomHome extends StatelessWidget {
  const RandomHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Random Module")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7),
        child: ListView.separated(
          itemCount: randomPagesList.length,
          separatorBuilder: (context, index) =>
              const Divider(thickness: 1, height: 2),
          itemBuilder: (context, index) {
            return ElevatedButton(
              onPressed: () =>
                  Modular.to.pushNamed(randomPagesList[index].pageRoute),
              child: Text(randomPagesList[index].pageName),
            );
          },
        ),
      ),
    );
  }
}
