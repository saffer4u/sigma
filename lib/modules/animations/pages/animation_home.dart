import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../animation_pages_list.dart';

class AnimationHome extends StatelessWidget {
  const AnimationHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animation Module"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        child: ListView.separated(
          itemCount: animationPagesList.length,
          separatorBuilder: (context, index) =>
              const Divider(thickness: 1, height: 2),
          itemBuilder: (context, index) {
            if (index == 0) {
              return SizedBox(
                height: 200,
                child: ElevatedButton(
                  onPressed: () =>
                      Modular.to.pushNamed(animationPagesList[index].pageRoute),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Hero(tag: 'logo', child: FlutterLogo(size: 150)),
                      Text(animationPagesList[index].pageName),
                    ],
                  ),
                ),
              );
            } else {
              return ElevatedButton(
                onPressed: () =>
                    Modular.to.pushNamed(animationPagesList[index].pageRoute),
                child: Text(animationPagesList[index].pageName),
              );
            }
          },
        ),
      ),
    );
  }
}
