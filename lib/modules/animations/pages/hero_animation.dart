import 'package:flutter/material.dart';

class HeroAnimation extends StatelessWidget {
  const HeroAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Hero Animation"),
      ),
      body:const Center(
        child: Hero(
          tag: "logo",
          child: FlutterLogo(size: 500),
        ),
      ),
    );
  }
}
