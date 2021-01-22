import 'package:flutter/material.dart';
import 'package:sailebot_app/screens/homes/home_screen.dart';
import 'package:sailebot_app/services/local_store_service.dart';
import 'package:sailebot_app/utils/utils.dart';
import 'package:sailebot_app/widgets/common_intro_widget.dart';
import 'package:sailebot_app/utils/extension.dart';

class ConfirmationCompletedQuestionScreen extends StatelessWidget {
  static final routeName = '/ConfirmationCompletedQuestionScreen';

  @override
  Widget build(BuildContext context) {
    Utils.homeStatusBar();
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: CommonIntroWidget(
              assetImage: 'assets/images/bg_noti_create_sailebot.png',
              widthImage: 216,
              ratioImage: 0.639344262,
              description:
                  'All done! Your Sailebot should be set to saile soon!',
              titleButton: 'GOT IT!',
              onPressed: () {
                LocalStoreService().isSetupSailebot = true;
                context.navigator.pushNamedAndRemoveUntil(
                  HomeScreen.routeName,
                  (route) => false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
