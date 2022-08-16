// Generate NeoMorphism code : https://neumorphism.coldstone.fun/#/

import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class NeoMorphismPage extends StatefulWidget {
  const NeoMorphismPage({Key? key}) : super(key: key);

  @override
  State<NeoMorphismPage> createState() => _NeoMorphismPageState();
}

class _NeoMorphismPageState extends State<NeoMorphismPage> {
  bool isPressed = true;
  bool isDarkMode = true;

  void toggleTheme() => setState(() => isDarkMode = !isDarkMode);

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        isDarkMode ? const Color(0XFF2E3239) : const Color(0xffe7ecef);
    Offset direction = isPressed ? const Offset(10, 10) : const Offset(28, 28);
    double blur = isPressed ? 5.0 : 30.0;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: backgroundColor,
          onPressed: toggleTheme,
          label: const Text("Change Theme")),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text("Neomorphism"),
      ),
      backgroundColor: backgroundColor,
      body: Center(
        child: GestureDetector(
          onTap: () => setState(() {
            isPressed = !isPressed;
          }),
          child: AnimatedContainer(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  inset: isPressed,
                  offset: -direction,
                  color: isDarkMode ? const Color(0XFF35393F) : Colors.white,
                  blurRadius: blur,
                ),
                BoxShadow(
                  inset: isPressed,
                  offset: direction,
                  color: isDarkMode
                      ? const Color(0XFF23262A)
                      : const Color(0xFFA7A9AF),
                  blurRadius: blur,
                ),
              ],
            ),
            duration: const Duration(milliseconds: 100),
            child: const SizedBox(
              width: 200,
              height: 200,
            ),
          ),
        ),
      ),
    );
  }
}
