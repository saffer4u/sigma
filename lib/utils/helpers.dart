import 'package:flutter/material.dart';

import '../constents/widget_keys.dart';

class Alerts {
  static showSnackBar(String message, {double? height}) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, height ?? 10.0),
    );
    WidgetKeys.rootScaffoldMessengerKey.currentState!.showSnackBar(snackBar);
  }

  static Future showBottomSheet(
    BuildContext context, {
    required Widget child,
    bool enableDrag = true,
    double? height,
    bool dismissOnBackClick = true,
  }) {
    return showModalBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      enableDrag: enableDrag,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
      ),
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: SizedBox(
            height: height,
            child: child,
          ),
        );
      },
    );
  }
}
