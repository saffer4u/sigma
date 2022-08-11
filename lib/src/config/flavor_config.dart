

enum Flavor {
  staging,
  production,
  development,
}

class FlavorValues {
  const FlavorValues({
    required this.baseUrl,
  });

  final String baseUrl;
}

class FlavorConfig {
  factory FlavorConfig({required Flavor flavor, required FlavorValues values}) {
    _instance ??= FlavorConfig._internal(
        flavor, flavor.toString().split('.').last, values);
    return _instance!;
  }

  FlavorConfig._internal(this.flavor, this.name, this.values);

  final Flavor flavor;
  final String name;
  final FlavorValues values;
  static FlavorConfig? _instance;
  static FlavorConfig? get instance => _instance;

  static bool isProduction() => _instance?.flavor == Flavor.production;
  static bool isStaging() => _instance?.flavor == Flavor.staging;
  static bool isDevelopment() => _instance?.flavor == Flavor.development;
}
