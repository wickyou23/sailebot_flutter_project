import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'extension.dart';

class Utils {
  static blackStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: ColorExt.colorWithHex(0xf0f0f0),
        statusBarBrightness:
            Platform.isIOS ? Brightness.light : Brightness.dark,
        statusBarIconBrightness:
            Platform.isIOS ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: Colors.blue,
      ),
    );
  }

  static whiteStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Platform.isIOS ? Colors.white : Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.blue,
      ),
    );
  }
}
