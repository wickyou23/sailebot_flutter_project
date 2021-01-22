import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:sailebot_app/data/view_model/question_vm.dart';
import 'package:sailebot_app/enum/question_section_enum.dart';
import 'package:sailebot_app/screens/homes/home_screen.dart';
import 'package:sailebot_app/screens/sailebot_setup/confirmation_save_question_screen.dart';
import 'package:sailebot_app/screens/sailebot_setup/product_question_screen.dart';
import 'package:sailebot_app/services/questionaire_service.dart';
import 'package:sailebot_app/utils/utils.dart';
import 'package:sailebot_app/widgets/custom_navigation_bar.dart';
import 'package:sailebot_app/utils/extension.dart';
import 'package:sailebot_app/widgets/quuestion_widget.dart';

class ProspectsQuestionScreen extends StatefulWidget {
  static final routeName = '/ProspectsQuestionScreen';

  @override
  _ProspectsQuestionScreenState createState() =>
      _ProspectsQuestionScreenState();
}

class _ProspectsQuestionScreenState extends State<ProspectsQuestionScreen> {
  final QuestionSectionEnum _myEnum = QuestionSectionEnum.prospects;
  int _currentQuestion = 0;
  List<QuestionViewModel> _questions = QuestionaireService()
      .getProspeetsQuestion()
      .map((e) => QuestionViewModel(mainQuestion: e))
      .toList();

  @override
  void initState() {
    Utils.authAppStatusBar();
    final qService = QuestionaireService();
    if (qService.isPendingProgress) {
      _currentQuestion =
          qService.currentSetup()[QuestionSectionEnum.prospects] ?? 0;
    }

    KeyboardVisibility.onChange.listen((event) {
      if (!event) {
        Future.delayed(Duration(milliseconds: 100), () {
          Utils.authAppStatusBar();
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint('${ProspectsQuestionScreen.routeName} dispose ===========');
  }

  @override
  Widget build(BuildContext context) {
    final itQuestion = _questions[_currentQuestion];

    return WillPopScope(
      onWillPop: () async {
        return _shouldBackScreen();
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
                      CustomNavigationBar.heightNavBar,
                  left: 25,
                  right: 25,
                ),
                child: _buildContentQuestion(itQuestion),
              ),
            ),
            CustomNavigationBar(
              navTitle: 'Prospects',
              bgImage: 'assets/images/bg_navi_prospects_question.png',
              backButtonOnPressed: () {
                if (_shouldBackScreen()) {
                  context.navigator.pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  bool _shouldBackScreen() {
    final qService = QuestionaireService();
    if (qService.isPendingProgress) {
      var stopHere = qService.currentSetup()[_myEnum] ?? 0;
      if (_currentQuestion == stopHere) {
        return true;
      }
    }

    if (_currentQuestion == 0) {
      return true;
    }

    var q = _questions[_currentQuestion];
    q.resetAllUserAnswer();
    _currentQuestion -= 1;
    setState(() {});
    return false;
  }

  Widget _buildContentQuestion(QuestionViewModel itQuestion) {
    return Container(
      color: Colors.white,
      height: context.media.size.height,
      child: SingleChildScrollView(
        child: QuestionWidget(
          key: ValueKey(itQuestion.id),
          q: itQuestion,
          saveOnPressed: () {
            QuestionaireService().setCurrentSetup({
              QuestionSectionEnum.prospects: _currentQuestion,
            });

            QuestionaireService().isShowBannerSaved = true;
            context.navigator.pushReplacementNamed(HomeScreen.routeName);
          },
          nextOnPressed: () {
            _currentQuestion += 1;
            if (_currentQuestion == _questions.length) {
              _currentQuestion -= 1;
              context.navigator.pushNamed(ProductQuestionScreen.routeName);
            } else {
              setState(() {});
            }
          },
        ),
      ),
    );
  }
}
