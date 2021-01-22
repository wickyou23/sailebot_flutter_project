import 'dart:math';

extension DoubleExt on double {
  double toRadian() {
    return (this * pi) / 180;
  }
}
