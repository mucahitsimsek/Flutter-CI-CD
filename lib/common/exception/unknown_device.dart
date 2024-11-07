final class UnknownDevice implements Exception {
  final String unsupportedFlavor;
  UnknownDevice(this.unsupportedFlavor);

  String get message => 'Unsupported Device: $unsupportedFlavor';
}
