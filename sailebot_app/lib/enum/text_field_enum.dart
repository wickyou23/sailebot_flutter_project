import 'package:flutter/material.dart';
import 'package:sailebot_app/utils/extension.dart';

enum CustomTextFormFieldType { normalStyle, blueStyle }

extension CustomTextFormFieldTypeExt on CustomTextFormFieldType {
  Color get titleColor {
    switch (this) {
      case CustomTextFormFieldType.blueStyle:
        return Colors.white;
      default:
        return Colors.black;
    }
  }

  Color get textColor {
    switch (this) {
      case CustomTextFormFieldType.blueStyle:
        return Colors.white;
      default:
        return Colors.black;
    }
  }

  Color get placeHolderColor {
    switch (this) {
      case CustomTextFormFieldType.blueStyle:
        return Colors.white60;
      default:
        return Colors.grey;
    }
  }

  Color get cursorColor {
    switch (this) {
      case CustomTextFormFieldType.blueStyle:
        return Colors.white;
      default:
        return ColorExt.colorWithHex(0x12B3FF);
    }
  }

  bool get isFilledTextField {
    return this == CustomTextFormFieldType.blueStyle;
  }
}