import 'models/random_page.dart';
import 'random_module.dart';

final List<RandomPage> randomPagesList = [
  RandomPage(
    pageName: "Barcode",
    pageRoute: RandomModuleRoute.getRoute(RandomModuleRoute.barcodePage),
  ),
  RandomPage(
    pageName: "Crypto",
    pageRoute: RandomModuleRoute.getRoute(RandomModuleRoute.cryptoPage),
  ),
  RandomPage(
    pageName: "Dart IPIFY",
    pageRoute: RandomModuleRoute.getRoute(RandomModuleRoute.dartIpify),
  ),
  RandomPage(
    pageName: "Neomorphism",
    pageRoute: RandomModuleRoute.getRoute(RandomModuleRoute.neoMorphism),
  ),
  RandomPage(
    pageName: "Responsive",
    pageRoute: RandomModuleRoute.getRoute(RandomModuleRoute.responsive),
  ),
];
