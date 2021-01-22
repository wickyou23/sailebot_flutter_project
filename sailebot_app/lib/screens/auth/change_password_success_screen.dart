import 'package:flutter/material.dart';
import 'package:sailebot_app/screens/auth/authentication_screen.dart';
import 'package:sailebot_app/utils/utils.dart';
import 'package:sailebot_app/widgets/common_intro_widget.dart';
import 'package:sailebot_app/utils/extension.dart';
import 'package:sailebot_app/wireframe.dart';

class ChangePasswordSuccessScreen extends StatelessWidget {
  static final routeName = '/ChangePasswordSuccessScreen';

  @override
  Widget build(BuildContext context) {
    Utils.homeStatusBar();

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 250),
              child: CommonIntroWidget(
                assetImage: 'assets/images/bg_success.png',
                widthImage: 110,
                description:
                    'Your password was changed successfully. Please use the new password to login again.',
                titleButton: 'GOT IT!',
                onPressed: () {
                  AppWireFrame.logout();
                  context.navigator.pushNamedAndRemoveUntil(
                    AuthenticationScreen.routeName,
                    (route) => false,
                    arguments: {'shouldShowSignupFirst': false},
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
