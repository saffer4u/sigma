
import 'package:sigma/src/config/flavor_config.dart';
import 'main_base.dart';

void main() {
  runMain(
    configInit: () => FlavorConfig(
      flavor: Flavor.production,
      values: const FlavorValues(
        baseUrl: "Production API base URL",
      ),
    ),
    dumpErrorToConsole: false,
  );
}
