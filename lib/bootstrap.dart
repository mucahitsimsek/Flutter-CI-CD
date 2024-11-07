import 'dart:developer';

import 'package:hadibucopy/base/config/flavor_config.dart';

void bootstrap() {
  final flavorConfig = FlavorConfiguration.instance;
  final baseUrl = flavorConfig.baseUrl;
  final environment = flavorConfig.environmentType.environment;
  log('baseUrl: $baseUrl | environment: $environment');

  /// Add your bootstrap code here
}
