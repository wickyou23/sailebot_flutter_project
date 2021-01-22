import 'package:flutter/material.dart';
import 'package:sailebot_app/enum/text_field_enum.dart';
import 'package:sailebot_app/utils/extension.dart';

class CustomTextFormField extends StatefulWidget {
  final Key key;
  final String title;
  final String placeHolder;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget suffixIcon;
  final TextEditingController controller;
  final CustomTextFormFieldType textFieldStyle;
  final bool readOnly;
  final bool enabled;
  final int maxLine;
  final VoidCallback onTap;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final Function(String) onFieldSubmitted;
  final String initialValue;
  final Function(String) onChanged;

  CustomTextFormField({
    this.key,
    this.title,
    this.placeHolder,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.controller,
    this.textFieldStyle = CustomTextFormFieldType.blueStyle,
    this.readOnly = false,
    this.enabled = true,
    this.maxLine = 1,
    this.onTap,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted,
    this.initialValue,
    this.onChanged,
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (this.widget.title != null || this.widget.title?.isNotEmpty == false) ...[
          Text(
            this.widget.title,
            textAlign: TextAlign.left,
            style: context.theme.textTheme.headline6.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: this.widget.textFieldStyle.titleColor,
            ),
          ),
          SizedBox(height: 10)
        ],
        TextFormField(
          obscureText: this.widget.obscureText,
          cursorColor: this.widget.textFieldStyle.cursorColor,
          enableSuggestions: false,
          autocorrect: false,
          keyboardType: this.widget.keyboardType,
          readOnly: this.widget.readOnly,
          enabled: this.widget.enabled,
          maxLines: this.widget.maxLine,
          focusNode: this.widget.focusNode,
          textInputAction: this.widget.textInputAction,
          onFieldSubmitted: this.widget.onFieldSubmitted,
          initialValue: this.widget.initialValue,
          controller: this.widget.controller,
          onChanged: this.widget.onChanged,
          style: context.theme.textTheme.headline5.copyWith(
            fontSize: 16,
            color: this.widget.textFieldStyle.textColor,
          ),
          decoration: InputDecoration(
            filled: this.widget.textFieldStyle.isFilledTextField,
            fillColor: Colors.white38,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 15,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: (this.widget.textFieldStyle.isFilledTextField)
                  ? BorderSide.none
                  : BorderSide(
                      color: ColorExt.colorWithHex(0x12B3FF),
                      width: 0.5,
                    ),
            ),
            hintText: this.widget.placeHolder,
            hintStyle: context.theme.textTheme.headline5.copyWith(
              fontSize: 16,
              color: this.widget.textFieldStyle.placeHolderColor,
            ),
            suffixIcon: this.widget.suffixIcon,
          ),
          onTap: this.widget.onTap,
        ),
      ],
    );
  }
}
