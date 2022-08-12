import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/app/app.dart';
import 'modules/app/sigma_app_modules.dart';
import 'src/config/flavor_config.dart';

void runMain({
  required FlavorConfig Function() configInit,
  required bool dumpErrorToConsole,
}) async {
  runZonedGuarded<Future<void>>(
    () async {
      await _init(configInit: configInit);
      runApp(ModularApp(module: SigmaAppModule(), child: App()));
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
  if (!kIsWeb) {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  FlavorConfig flavorConfig = configInit();
}
