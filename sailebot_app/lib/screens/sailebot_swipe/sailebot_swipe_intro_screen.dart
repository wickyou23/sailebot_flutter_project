import 'package:flutter/material.dart';
import 'package:sailebot_app/screens/sailebot_swipe/sailebot_swipe_screen.dart';
import 'package:sailebot_app/utils/extension.dart';
import 'package:sailebot_app/utils/utils.dart';

class SaileBotSwipeIntroScreen extends StatelessWidget {
  static final routeName = '/SaileBotSwipeIntro';

  @override
  Widget build(BuildContext context) {
    var goBackHandler = context.routeArg as Function;
    Utils.authAppStatusBar();

    return Scaffold(
      body: Container(
        height: double.infinity,
        child: Column(
          children: <Widget>[
            ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: context.media.size.width * 0.834259259,
              ),
              child: Image(
                image: AssetImage('assets/images/bg_sailbot_swipe_intro.png'),
                width: context.media.size.width,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: context.isSmallDevice ? 25 : 35,
            ),
            RichText(
              text: TextSpan(
                text: 'Saileswipe',
                style: context.theme.appBarTheme.textTheme.headline6.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                  color: Colors.black,
                ),
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.top,
                    child: Text(
                      'TM',
                      style: context.theme.appBarTheme.textTheme.headline6
                          .copyWith(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Swipe through leads to match with prospects, or add them to your Sailebot for targeting',
                style: context.theme.textTheme.headline5.copyWith(
                  color: ColorExt.myBlack,
                  fontSize: 19,
                  height: 1.3,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 40),
            Container(
              width: context.media.size.width,
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 25),
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
                        .pushReplacementNamed(SaileBotSwipeScreen.routeName)
                        .then((value) {
                      if (goBackHandler != null) {
                        goBackHandler();
                      }
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
