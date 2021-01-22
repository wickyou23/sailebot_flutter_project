import 'package:flutter/material.dart';
import 'package:sailebot_app/utils/extension.dart';

class Constaint {
  static const String passwordRex = '^(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$%^&*]).{8,}\$';
  static const String emailRex = '[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}';
  static final Color mainColor = ColorExt.colorWithHex(0x12B3FF);
  static final Color naviBarColor = ColorExt.colorWithHex(0x098EF5);
}