import 'package:flutter/material.dart';
import 'package:sailebot_app/screens/sailebot_setup/prospects_question_screen.dart';
import 'package:sailebot_app/widgets/custom_navigation_bar.dart';
import 'package:sailebot_app/utils/extension.dart';

class IntroQuestionaireScreen extends StatelessWidget {
  static final routeName = '/IntroQuestionaireScreen';

  @override
  Widget build(BuildContext context) {
    var dCircle = (context.media.size.width - 20) / 5;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomNavigationBar(
            navTitle: '',
            tintColor: Colors.black,
          ),
          Center(
            child: Column(
              key: this.key,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Image.asset(
                    'assets/images/bg_intro_questionaire.png',
                    fit: BoxFit.cover,
                    width: 260,
                    height: 0.6803278689 * 260,
                  ),
                ),
                SizedBox(height: (context.isSmallDevice) ? 15 : 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _circle(context, dCircle, 'Prospects'),
                    Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/ic_arrow_left.png',
                        fit: BoxFit.fitWidth,
                        width: 26,
                        height: 26,
                      ),
                    ),
                    _circle(context, dCircle, 'Product'),
                    Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/ic_arrow_left.png',
                        fit: BoxFit.fitWidth,
                        width: 26,
                        height: 26,
                      ),
                    ),
                    _circle(context, dCircle, 'Personality'),
                  ],
                ),
                SizedBox(height: (context.isSmallDevice) ? 15.0 : 25.0),
                Padding(
                  padding: EdgeInsets.only(
                    left: 25.0,
                    right: 25.0,
                    bottom: (context.isSmallDevice) ? 15.0 : 25.0,
                  ),
                  child: Text(
                    'Sailebots generate Actionable Opportunities using AI and intelligent email that engages perfect prospects on your behalf.',
                    style: context.theme.textTheme.headline5.copyWith(
                      fontSize: 19,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: (context.isSmallDevice) ? 15 : 30),
                Container(
                  width: context.media.size.width - 50,
                  height: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: RaisedButton(
                      child: Text(
                        'START',
                        style: context.theme.textTheme.button.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      color: ColorExt.colorWithHex(0x098EF5),
                      onPressed: () {
                        context.navigator
                            .pushReplacementNamed(
                                ProspectsQuestionScreen.routeName)
                            .then((value) {
                          // Future.delayed(Duration(milliseconds: 100), () {
                          //   Utils.homeStatusBar();
                          // });
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _circle(BuildContext context, double width, String text) {
    return Material(
      type: MaterialType.circle,
      color: ColorExt.colorWithHex(0xEBF8FF),
      child: Container(
        width: width,
        height: width,
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: context.theme.textTheme.subtitle2.copyWith(
              fontSize: 12,
              color: ColorExt.colorWithHex(0x098EF5),
            ),
          ),
        ),
      ),
    );
  }
}
