import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  const Loader({
    Key? key,
    required this.child,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return child;
    }
  }
}
