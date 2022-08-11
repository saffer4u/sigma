import 'dart:math';

import 'package:flutter/material.dart';
class ImplicitAnimations extends StatefulWidget {
  const ImplicitAnimations({Key? key}) : super(key: key);

  @override
  State<ImplicitAnimations> createState() => _ImplicitAnimationsState();
}

class _ImplicitAnimationsState extends State<ImplicitAnimations> {
  bool _isBigger = false;
  // static final colorTween = ColorTween(begin: Colors.white, end: Colors.orange);
  double _sliderValue = 0;
  Color _newColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Implicit Animations"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AnimatedContainer(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                        colors: const [Colors.blue, Colors.transparent],
                        stops: [_isBigger ? 0.2 : 0.5, 1.0]),
                  ),
                  curve: Curves.easeInOutCubic,
                  duration: const Duration(seconds: 1),
                  height: _isBigger ? 300 : 50,
                  child: const FlutterLogo(),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isBigger = !_isBigger;
                    });
                  },
                  child: const Text("Animated Container"),
                ),
                SizedBox(
                  height: 300,
                  child: TweenAnimationBuilder(
                    tween: ColorTween(begin: Colors.white, end: _newColor),
                    duration: const Duration(seconds: 1),
                    child: const FlutterLogo(),
                    builder: (_, Color? color, Widget? myWidget) {
                      return ColorFiltered(
                        colorFilter:
                            ColorFilter.mode(color!, BlendMode.modulate),
                        child: myWidget,
                      );
                    },
                  ),
                ),
                Slider.adaptive(
                  value: _sliderValue,
                  onChanged: (double value) {
                    setState(() {
                      _sliderValue = value;
                      _newColor =
                          Color.lerp(Colors.white, Colors.red, _sliderValue)!;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//* can make custom curves by this

class SineCurve extends Curve {
  final double count;
  const SineCurve({this.count = 1});

  @override
  double transformInternal(double t) {
    return sin(count * 2 * pi * t) * 0.5 + 0.5;
  }
}
