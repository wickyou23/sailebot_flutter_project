import 'package:flutter/material.dart';
import 'package:sailebot_app/enum/question_section_enum.dart';
import 'package:sailebot_app/screens/sailebot_setup/personality_question.screen.dart';
import 'package:sailebot_app/screens/sailebot_setup/product_question_screen.dart';
import 'package:sailebot_app/screens/sailebot_setup/prospects_question_screen.dart';
import 'package:sailebot_app/services/questionaire_service.dart';
import 'package:sailebot_app/utils/utils.dart';
import 'package:sailebot_app/widgets/custom_navigation_bar.dart';
import 'package:sailebot_app/utils/extension.dart';

class ResumeQuestionaireScreen extends StatelessWidget {
  static final routeName = '/ResumeQuestionaireScreen';

  @override
  Widget build(BuildContext context) {
    Utils.blackStatusBar();
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Text(
                    'Come back to where you left off last time',
                    textAlign: TextAlign.center,
                    style: context.theme.textTheme.headline5.copyWith(
                      fontSize: 19,
                      height: 1.5,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: context.media.size.width - 40,
                  height: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: RaisedButton(
                      child: Text(
                        'RESUME PROGRESS',
                        style: context.theme.textTheme.button.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      color: ColorExt.colorWithHex(0x098EF5),
                      onPressed: () {
                        _resumeProgress(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          CustomNavigationBar(
            tintColor: ColorExt.myBlack,
            navTitle: 'Resume Progress',
          )
        ],
      ),
    );
  }

  void _resumeProgress(BuildContext context) {
    final qService = QuestionaireService();
    if (!qService.isPendingProgress) {
      return;
    }

    var section = qService.currentSetup().keys.first;
    switch (section) {
      case QuestionSectionEnum.prospects:
        context.navigator
            .pushReplacementNamed(ProspectsQuestionScreen.routeName);
        break;
      case QuestionSectionEnum.product:
        context.navigator.pushReplacementNamed(ProductQuestionScreen.routeName);
        break;
      case QuestionSectionEnum.personality:
        context.navigator
            .pushReplacementNamed(PersonalityQuestionScreen.routeName);
        break;
      default:
        break;
    }
  }
}
