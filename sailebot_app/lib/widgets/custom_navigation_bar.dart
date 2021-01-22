import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sailebot_app/utils/extension.dart';

class CustomNavigationBar extends StatelessWidget {
  static final double heightNavBar = 70;

  final String navTitle;
  final Color tintColor;
  final Color backgroundColor;
  final Widget rightBarIcon;
  final String bgImage;
  final Function rightBarOnPressed;
  final Function backButtonOnPressed;

  CustomNavigationBar({
    @required this.navTitle,
    this.tintColor = Colors.white,
    this.backgroundColor = Colors.transparent,
    this.rightBarIcon,
    this.rightBarOnPressed,
    this.bgImage,
    this.backButtonOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: context.media.viewPadding.top),
      height: CustomNavigationBar.heightNavBar + context.media.viewPadding.top,
      decoration: _getBoxDecoration(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Text(
                this.navTitle,
                textAlign: TextAlign.center,
                style: context.theme.appBarTheme.textTheme.headline5.copyWith(
                  fontSize: 27,
                  color: this.tintColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 4.0),
              alignment: Alignment.centerLeft,
              child: Row(
                children: <Widget>[
                  CupertinoButton(
                    padding: const EdgeInsets.only(
                      top: 16,
                      bottom: 16,
                      left: 0,
                      right: 10,
                    ),
                    minSize: 20,
                    child: Icon(
                      Icons.arrow_back,
                      color: this.tintColor,
                      size: 30,
                    ),
                    onPressed: () {
                      if (this.backButtonOnPressed != null) {
                        this.backButtonOnPressed();
                      } else {
                        context.navigator.pop();
                      }
                    },
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  if (this.rightBarIcon != null)
                    CupertinoButton(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 16,
                      ),
                      minSize: 20,
                      child: this.rightBarIcon,
                      onPressed: this.rightBarOnPressed,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _getBoxDecoration() {
    return (this.bgImage != null)
        ? BoxDecoration(
            image: DecorationImage(
                image: AssetImage(this.bgImage), fit: BoxFit.cover),
          )
        : BoxDecoration(
            color: this.backgroundColor,
          );
  }
}
