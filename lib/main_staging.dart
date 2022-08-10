import 'main_base.dart';
import 'src/config/flavor_config.dart';

void main() {
  runMain(
    configInit: () => FlavorConfig(
      flavor: Flavor.staging,
      values: const FlavorValues(
        baseUrl: "Staging API base URL",
      ),
    ),
    dumpErrorToConsole: true,
  );
}
