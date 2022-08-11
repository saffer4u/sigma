import 'package:flutter_modular/flutter_modular.dart';

import '../app/sigma_app_modules.dart';
import 'pages/barcode_page.dart';
import 'pages/crypto_page.dart';
import 'pages/dart_ipify_page.dart';
import 'pages/random_home.dart';

class RandomModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          RandomModuleRoute.randomHome,
          child: (context, args) => const RandomHome(),
        ),
         ChildRoute(
          RandomModuleRoute.barcodePage,
          child: (context, args) => const BarcodePage(),
        ),
         ChildRoute(
          RandomModuleRoute.cryptoPage,
          child: (context, args) => const CryptoPage(),
        ),
         ChildRoute(
          RandomModuleRoute.dartIpify,
          child: (context, args) => const DartIpifyPage(),
        ),
      ];
}

abstract class RandomModuleRoute {
  static const String barcodePage = "/barcode_page";
  static const String cryptoPage = "/crypto_page";
  static const String dartIpify = "/dart_ipify";
  static const String randomHome = "/random_home";

  static String getRoute(String route) {
    return SigmaAppModuleRoute.random + route;
  }
}
