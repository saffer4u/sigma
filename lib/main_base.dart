import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sigma/app.dart';
import 'package:sigma/src/config/flavor_config.dart';

void runMain({
  required FlavorConfig Function() configInit,
  required bool dumpErrorToConsole,
}) async {
  runZonedGuarded<Future<void>>(
    () async {
      await _init(configInit: configInit);
      runApp(App());
    },
    (error, stack) {
      final details = FlutterErrorDetails(exception: error, stack: stack);
      if (dumpErrorToConsole) {
        FlutterError.dumpErrorToConsole(details);
      }
    },
  );
}

Future<void> _init({
  required FlavorConfig Function() configInit,
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FlavorConfig flavorConfig = configInit();
}
