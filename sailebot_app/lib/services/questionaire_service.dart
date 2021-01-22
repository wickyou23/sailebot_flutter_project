import 'package:flutter/cupertino.dart';
import 'package:sailebot_app/enum/answer_enum.dart';
import 'package:sailebot_app/enum/question_section_enum.dart';
import 'package:sailebot_app/models/answer_object.dart';
import 'package:sailebot_app/models/question_object.dart';
import 'package:sailebot_app/screens/sailebot_setup/intro_questionaire_screen.dart';
import 'package:sailebot_app/screens/sailebot_setup/resume_questionaire_screen.dart';
import 'package:sailebot_app/services/local_store_service.dart';
import 'package:sailebot_app/utils/extension.dart';

class QuestionaireService {
  static final QuestionaireService _singleton = QuestionaireService._internal();

  QuestionaireService._internal();

  factory QuestionaireService() {
    return _singleton;
  }

  Map<QuestionSectionEnum, int> _currentSetup;
  Map<QuestionSectionEnum, int> currentSetup() {
    if (_currentSetup == null) {
      _currentSetup = LocalStoreService().currentQuestionSetup;
    }

    return _currentSetup;
  }

  void setCurrentSetup(Map<QuestionSectionEnum, int> newCurrentSetup) {
    _currentSetup = newCurrentSetup;
    LocalStoreService().currentQuestionSetup = newCurrentSetup;
  }

  bool isShowBannerSaved = false;

  bool get isPendingProgress {
    return this.currentSetup() != null;
  }

  void startQuestionaire(BuildContext context) {
    if (!this.isPendingProgress) {
      context.navigator.pushNamed(IntroQuestionaireScreen.routeName);
    } else {
      context.navigator.pushNamed(ResumeQuestionaireScreen.routeName);
    }
  }

  void clean() {
    _currentSetup = null;
  }
}

extension DataQuestionaire on QuestionaireService {
  List<QuestionObject> getProspeetsQuestion() {
    return _allQuestion[QuestionSectionEnum.prospects];
  }

  List<QuestionObject> getProductQuestion() {
    return _allQuestion[QuestionSectionEnum.product];
  }

  List<QuestionObject> getPersonalityQuestion() {
    return _allQuestion[QuestionSectionEnum.personality];
  }
}

Map<QuestionSectionEnum, List<QuestionObject>> _allQuestion = {
  QuestionSectionEnum.prospects: [
    QuestionObject(
      question:
          'Describe your target Geography as you know it (ex: Europe, United States, Northeast, New York.).',
      anwsers: [
        AnswerObject(
          type: AnswerEnum.selectType,
          sugestionAnswer: ['Answer_1', 'Answer_2', 'Answer_3'],
        ),
      ],
    ),
    QuestionObject(
      question:
          'List any keywords that describe the typical decision-makers role (ex: Data, Engineer, Financial...)',
      anwsers: [
        AnswerObject(
          type: AnswerEnum.inputType,
          placeHolder: 'Type keyword here',
        ),
        AnswerObject(
          type: AnswerEnum.inputType,
          placeHolder: 'Type keyword here',
        ),
        AnswerObject(
          type: AnswerEnum.inputType,
          placeHolder: 'Type keyword here',
        ),
      ],
    ),
    QuestionObject(
      question: 'Please select the areas of the org-chart you converse with',
      anwsers: [
        AnswerObject(type: AnswerEnum.multipleSelectType, sugestionAnswer: [
          'Board',
          'C',
          'Pres.',
          'EVP',
          'S/AVP',
          'Head',
          'VP',
          'Dir.',
          'Mgr.',
          'Admin',
          'Support'
        ]),
        AnswerObject(type: AnswerEnum.inputType, placeHolder: 'Other')
      ],
    ),
    QuestionObject(
      question: 'How many new prospect meetings did you have last week?',
      anwsers: [
        AnswerObject(
          type: AnswerEnum.selectType,
          sugestionAnswer: ['Answer_1', 'Answer_2', 'Answer_3'],
        )
      ],
    ),
    QuestionObject(
      question:
          'List examples of companies, industries or verticals your Sailebot should target.\n\nMultiple industries are acceptable, more can always be added.',
      anwsers: [
        AnswerObject(
          type: AnswerEnum.selectType,
          sugestionAnswer: ['Answer_1', 'Answer_2', 'Answer_3'],
        ),
        AnswerObject(
          type: AnswerEnum.selectType,
          sugestionAnswer: ['Answer_1', 'Answer_2', 'Answer_3'],
        ),
        AnswerObject(
          type: AnswerEnum.selectType,
          sugestionAnswer: ['Answer_1', 'Answer_2', 'Answer_3'],
        ),
      ],
    ),
  ],
  QuestionSectionEnum.product: [
    QuestionObject(
      question:
          'How are your solutions different from “similar” companies or competitors?',
      anwsers: [
        AnswerObject(
          type: AnswerEnum.inputType,
          placeHolder: 'Write your answer here',
        )
      ],
      isOptional: true,
    ),
    QuestionObject(
      question:
          'Please list three critical value propositions for your solution:',
      anwsers: [
        AnswerObject(
          type: AnswerEnum.inputType,
          placeHolder: 'Write your answer here',
        ),
        AnswerObject(
          type: AnswerEnum.inputType,
          placeHolder: 'Write your answer here',
        ),
        AnswerObject(
          type: AnswerEnum.inputType,
          placeHolder: 'Write your answer here',
        ),
      ],
    ),
    QuestionObject(
      question:
          'What’s the worst case scenario when a company doesn’t address the problem your solution solve?',
      anwsers: [
        AnswerObject(
          type: AnswerEnum.multipleInputType,
          placeHolder: 'Write your answer here',
        ),
      ],
    ),
    QuestionObject(
      question:
          'Please provide a high-level company description (Tip: you can provide your company website, schedule a call, or write out the description below).',
      anwsers: [
        AnswerObject(
          type: AnswerEnum.multipleInputType,
          placeHolder: 'Write your answer here',
        ),
      ],
    ),
  ],
  QuestionSectionEnum.personality: [
    QuestionObject(
      question:
          'Who is this Sailebot cloning?\n(Tip: Usually one Sales Executive has their own unique Sailebot)',
      anwsers: [
        AnswerObject(
          type: AnswerEnum.inputType,
          placeHolder: 'Name',
        ),
        AnswerObject(
          type: AnswerEnum.inputType,
          placeHolder: 'Title',
        ),
        AnswerObject(
          type: AnswerEnum.inputType,
          placeHolder: 'TimeZone',
        ),
        AnswerObject(
          type: AnswerEnum.inputType,
          placeHolder: 'Email',
          inputType: TextInputType.emailAddress,
        ),
        AnswerObject(
          type: AnswerEnum.inputType,
          placeHolder: 'Phone',
          inputType: TextInputType.phone,
        ),
      ],
    ),
    QuestionObject(
      question: 'Should anyone be cc\'ed on Opportunity Delivery?',
      anwsers: [
        AnswerObject(
          type: AnswerEnum.inputType,
          placeHolder: 'Name',
        ),
        AnswerObject(
          type: AnswerEnum.inputType,
          placeHolder: 'Title',
        ),
        AnswerObject(
          type: AnswerEnum.inputType,
          placeHolder: 'Email Address',
          inputType: TextInputType.emailAddress,
        ),
      ],
    ),
    QuestionObject(
      question: 'The Sailebot is',
      anwsers: [
        AnswerObject(
          type: AnswerEnum.picker,
          sugestionAnswer: ['Masculine', 'Feminine', 'Neutral'],
        )
      ],
    ),
    QuestionObject(
      description:
          'Quickly complete the initial personality profile of your Sailebot.',
      question: 'How long have you been in your current role?',
      forceHideAnswerTitle: true,
      anwsers: [
        AnswerObject(
          type: AnswerEnum.selectType,
          placeHolder: 'Select one',
          sugestionAnswer: ['Answer_1', 'Answer_2', 'Answer_3'],
        ),
      ],
      subQuestions: [
        SubQuestionObject(
          question: 'How long have you been in your industry?',
          forceHideAnswerTitle: true,
          anwsers: [
            AnswerObject(
              type: AnswerEnum.selectType,
              placeHolder: 'Select one',
              sugestionAnswer: ['Answer_1', 'Answer_2', 'Answer_3'],
            ),
          ],
        ),
      ],
    ),
    QuestionObject(
      question: 'What’s your hometown?',
      forceHideAnswerTitle: true,
      anwsers: [
        AnswerObject(
          type: AnswerEnum.inputType,
          placeHolder: 'Type your answer here',
        ),
      ],
      subQuestions: [
        SubQuestionObject(
          question: 'What’s your current city?',
          forceHideAnswerTitle: true,
          anwsers: [
            AnswerObject(
              type: AnswerEnum.inputType,
              placeHolder: 'Type your answer here',
            ),
          ],
        ),
      ],
    ),
    QuestionObject(
      question:
          'What will every prospect know about you after just one meeting?',
      forceHideAnswerTitle: true,
      anwsers: [
        AnswerObject(
          type: AnswerEnum.inputType,
          placeHolder: 'Type your answer here',
        )
      ],
    ),
    QuestionObject(
      question: 'What are some of your hobbies?',
      forceHideAnswerTitle: true,
      anwsers: [
        AnswerObject(
          type: AnswerEnum.inputType,
          placeHolder: 'Type your answer here',
        )
      ],
    ),
    QuestionObject(
      question: 'What’s your favorite band, artist, group or genre?',
      forceHideAnswerTitle: true,
      anwsers: [
        AnswerObject(
          type: AnswerEnum.inputType,
          placeHolder: 'Type your answer here',
        )
      ],
    ),
    QuestionObject(
      question: 'What characteristics describe your business acumen?',
      forceHideAnswerTitle: true,
      anwsers: [
        AnswerObject(
          type: AnswerEnum.multipleSelectType,
          sugestionAnswer: [
            'Assertive',
            'Relaxed',
            'Comedic',
            'Expert',
            'Create Value',
            'Determined',
            'Messured',
            'Charming',
            'Clever',
          ],
          columnForMultipleSelected: 2,
        ),
        AnswerObject(type: AnswerEnum.inputType, placeHolder: 'Other')
      ],
    ),
    QuestionObject(
      question: 'Where was the last place you traveled for business',
      forceHideAnswerTitle: true,
      anwsers: [
        AnswerObject(
            type: AnswerEnum.inputType, placeHolder: 'Type your answer here')
      ],
    ),
  ],
};
