import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class ConfettiAnimationPage extends StatefulWidget {
  const ConfettiAnimationPage({Key? key}) : super(key: key);

  @override
  State<ConfettiAnimationPage> createState() => _ConfettiAnimationPageState();
}

class _ConfettiAnimationPageState extends State<ConfettiAnimationPage> {
  final confettiController = ConfettiController();
  bool isPlaying = false;

  @override
  void initState() {
    confettiController.addListener(() {
      setState(() {
        isPlaying = confettiController.state == ConfettiControllerState.playing;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
              title: const Text("Confetti Animation"),
              backgroundColor: Colors.transparent),
          body: Center(
              child: ElevatedButton(
            child: Text(isPlaying ? "Stop" : "Celebrate"),
            onPressed: () {
              if (isPlaying) {
                confettiController.stop();
              } else {
                confettiController.play();
              }
            },
          )),
        ),
        ConfettiWidget(
          confettiController: confettiController,
          shouldLoop: true,
          blastDirectionality: BlastDirectionality.explosive,
          emissionFrequency: 0.6,
          minBlastForce: 10,
          maxBlastForce: 100,
        ),
      ],
    );
  }
}
