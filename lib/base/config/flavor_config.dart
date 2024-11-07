import 'package:hadibucopy/common/exception/unknown_device.dart';

part 'flavor_const.dart';

final class FlavorConfiguration {
  final EnvironmentType environmentType;
  final String baseUrl;

  FlavorConfiguration._({required this.environmentType, required this.baseUrl});

  static final _env = EnvironmentType.currentEnv;

  static final FlavorConfiguration instance = FlavorConfiguration._(
    environmentType: _env,
    baseUrl: _env.baseUrl,
  );
}

enum EnvironmentType {
  dev(FlavorConst.dev),
  stage(FlavorConst.stage),
  prod(FlavorConst.prod);

  const EnvironmentType(this.environment);

  final String environment;

  static EnvironmentType get currentEnv => EnvironmentType.fromString(
      const String.fromEnvironment(FlavorConst.environment));

  String get baseUrl {
    return switch (currentEnv) {
      dev => FlavorConst.devUrl,
      stage => FlavorConst.stageUrl,
      prod => FlavorConst.prodUrl,
    };
  }

  static EnvironmentType fromString(String value) {
    return EnvironmentType.values.firstWhere(
      (e) => e.environment == value,
      orElse: () => throw UnknownDevice(value),
    );
  }

  bool get isDev => currentEnv == dev;
  bool get isStage => currentEnv == stage;
  bool get isProd => currentEnv == prod;
}
