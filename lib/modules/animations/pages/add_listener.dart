import 'package:flutter/material.dart';

class AddListenerPage extends StatefulWidget {
  const AddListenerPage({Key? key}) : super(key: key);

  @override
  State<AddListenerPage> createState() => _AddListenerPageState();
}

class _AddListenerPageState extends State<AddListenerPage>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();

    // animation.removeListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              height: animation.value,
              width: animation.value,
              child: const FlutterLogo(),
            ),
            
          ],
        ),
      ),
    );
  }
}
