import 'package:flutter/material.dart';
import 'package:sailebot_app/utils/extension.dart';
import 'package:sailebot_app/utils/utils.dart';

class IntroducePage extends StatelessWidget {
  final String description;
  final String title;
  final Widget wtitle;
  final Widget wDescription;
  final ImageProvider image;

  IntroducePage({
    @required this.image,
    @required this.description,
    this.title = 'SaileBot',
    this.wtitle,
    this.wDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: Stack(
        children: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: context.media.size.width * 0.943518519,
            ),
            child: Image(
              image: this.image,
              width: context.media.size.width,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                top: (context.media.size.width * 0.943518519) -
                    (context.isSmallDevice ? 20 : 0)),
            child: Column(
              children: <Widget>[
                _buildTitle(context),
                SizedBox(height: (context.isSmallDevice) ? 16 : 30),
                _buildDesciption(context),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    if (this.wtitle != null) {
      return this.wtitle;
    } else {
      return Text(
        this.title,
        textAlign: TextAlign.center,
        style: context.theme.appBarTheme.textTheme.headline6.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 36,
          color: ColorExt.myBlack,
        ),
      );
    }
  }

  Widget _buildDesciption(BuildContext context) {
    if (this.wDescription != null) {
      return this.wDescription;
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Text(
          this.description,
          style: context.theme.textTheme.headline5.copyWith(
            color: ColorExt.myBlack,
            fontSize: 19,
            height: 1.3,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }
  }
}
