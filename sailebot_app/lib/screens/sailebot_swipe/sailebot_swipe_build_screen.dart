import 'package:flutter/material.dart';
import 'package:sailebot_app/services/questionaire_service.dart';
import 'package:sailebot_app/utils/utils.dart';
import 'package:sailebot_app/widgets/custom_navigation_bar.dart';
import 'package:sailebot_app/utils/extension.dart';

class SaileBotSwipeBuildScreen extends StatelessWidget {
  static final routeName = '/SaileBotSwipeBuildScreen';

  final double _widthImage = 260;

  @override
  Widget build(BuildContext context) {
    Utils.blackStatusBar();
    return Scaffold(
      body: Column(
        children: <Widget>[
          CustomNavigationBar(
            navTitle: '',
            tintColor: Colors.black,
          ),
          SizedBox(height: 20),
          _confirmBuildSaileBotPage(context),
        ],
      ),
    );
  }

  Widget _confirmBuildSaileBotPage(BuildContext context) {
    return Column(
      key: ValueKey('_confirmLaunchSaileBotPage'),
      children: <Widget>[
        Container(
          child: Image.asset(
            'assets/images/bg_sailebot_swipe_build.png',
            fit: BoxFit.cover,
            width: _widthImage,
            height: 0.680327869 * _widthImage,
          ),
        ),
        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Text(
            'You\'ve swiped right to qualify 3 contacts. Create your Sailebot to act upon these opportunities.',
            style: context.theme.textTheme.headline5.copyWith(
              fontSize: 19,
              height: 1.3,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 30),
        Container(
          width: context.media.size.width - 50,
          height: 50,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: RaisedButton(
              child: Text(
                'BUILD SAILEBOT',
                style: context.theme.textTheme.button.copyWith(
                  color: Colors.white,
                ),
              ),
              color: ColorExt.colorWithHex(0x098EF5),
              onPressed: () {
                QuestionaireService().startQuestionaire(context);
              },
            ),
          ),
        ),
      ],
    );
  }
}
