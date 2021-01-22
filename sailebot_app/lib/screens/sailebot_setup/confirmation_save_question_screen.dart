import 'package:flutter/material.dart';
import 'package:sailebot_app/enum/question_section_enum.dart';
import 'package:sailebot_app/screens/homes/home_screen.dart';
import 'package:sailebot_app/services/questionaire_service.dart';
import 'package:sailebot_app/widgets/custom_navigation_bar.dart';
import 'package:sailebot_app/utils/extension.dart';

class ConfirmationSaveQuestionScreen extends StatelessWidget {
  static final routeName = '/ConfirmationSaveQuestionScreen';

  @override
  Widget build(BuildContext context) {
    final section = QuestionaireService().currentSetup().keys.first;

    return WillPopScope(
      onWillPop: () async {
        QuestionaireService().setCurrentSetup(null);
        return true;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.only(
                  top: context.media.viewPadding.top +
                      CustomNavigationBar.heightNavBar +
                      20,
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
                child: _buildContent(context),
              ),
            ),
            CustomNavigationBar(
              navTitle: section?.navTitle ?? '',
              bgImage: section?.bgNaviImage ?? '',
              backButtonOnPressed: () {
                QuestionaireService().setCurrentSetup(null);
                context.navigator.pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Please use this section to describe ideal prospects or current customers as a model for future prospects.\n\nCurrent or pending clients will be removed at a later step.',
          style: context.theme.textTheme.headline5,
        ),
        SizedBox(height: 60),
        Container(
          width: 200,
          height: 50,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: RaisedButton(
              child: Text(
                'START',
                style: context.theme.textTheme.button.copyWith(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
              color: ColorExt.colorWithHex(0x098EF5),
              onPressed: () {
                // QuestionaireService().isShowBannerSaved = true;
                // context.navigator.popUntil((route) => false);
                // context.navigator.pushNamedAndRemoveUntil(
                //   HomeScreen.routeName,
                //   (route) => false,
                // );
                // context.navigator.pushReplacementNamed(HomeScreen.routeName);
                // context.navigator.popUntil((route) {
                //   bool isPop = false;
                //   if (route.settings.name == HomeScreen.routeName) {
                //     isPop = true;
                //   }

                //   if (!isPop && !route.navigator.canPop()) {
                //     route.navigator.pushReplacementNamed(HomeScreen.routeName);
                //     return true;
                //   }

                //   return isPop;
                // });
              },
            ),
          ),
        ),
      ],
    );
  }
}
