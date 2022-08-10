import 'package:sigma/main_base.dart';
import 'package:sigma/src/config/flavor_config.dart';

void main() {
  runMain(
    configInit: () => FlavorConfig(
      flavor: Flavor.development,
      values: const FlavorValues(
        baseUrl: "Development API base URL",
      ),
    ),
    dumpErrorToConsole: true,
  );
}
