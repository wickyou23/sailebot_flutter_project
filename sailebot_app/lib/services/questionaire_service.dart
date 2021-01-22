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

  List<String> getIndustries() {
    return _industries;
  }
}

Map<QuestionSectionEnum, List<QuestionObject>> _allQuestion = {
  QuestionSectionEnum.prospects: [
    QuestionObject(
      question:
          'Describe your target Geography as you know it (ex: Europe, United States, Northeast, New York.).',
      anwsers: [
        AnswerObject(
          type: AnswerEnum.inputType,
          placeHolder: 'Write your answer here',
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
          sugestionAnswer: ['Less than 5', '5 - 10', '10 or more'],
        )
      ],
    ),
    QuestionObject(
      question:
          'List examples of companies, industries or verticals your Sailebot should target.\n\nMultiple industries are acceptable, more can always be added.',
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
      question: '*This Sailebot is:',
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
          sugestionAnswer: [
            'Less than a year',
            '1-3 Years',
            '3 Years+',
          ],
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
              sugestionAnswer: [
                'Less than a year',
                '1-5 Years',
                '5 Years+',
              ],
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

const List<String> _industries = const [
  'Accommodation',
  'Accommodation and Food Services',
  'Administrative and Support Services',
  'Administrative and Support and Waste Management and Remediation Services',
  'Agriculture, Forestry, Fishing and Hunting',
  'Air Transportation',
  'Ambulatory Health Care Services',
  'Amusement, Gambling, and Recreation Industries',
  'Animal Production',
  'Apparel Manufacturing',
  'Arts, Entertainment, and Recreation',
  'Beverage and Tobacco Product Manufacturing',
  'Broadcasting (except Internet)',
  'Building Material and Garden Equipment and Supplies Dealers',
  'Chemical Manufacturing',
  'Clothing and Clothing Accessories Stores',
  'Computer and Electronic Product Manufacturing',
  'Construction',
  'Construction of Buildings',
  'Couriers and Messengers',
  'Credit Intermediation and Related Activities',
  'Crop Production',
  'Data Processing, Hosting, and Related Services',
  'Education and Health Services',
  'Educational Services',
  'Electrical Equipment, Appliance, and Component Manufacturing',
  'Electronics and Appliance Stores',
  'Fabricated Metal Product Manufacturing',
  'Finance and Insurance',
  'Financial Activities',
  'Fishing, Hunting and Trapping',
  'Food Manufacturing',
  'Food Services and Drinking Places',
  'Food and Beverage Stores',
  'Forestry and Logging',
  'Funds, Trusts, and Other Financial Vehicles',
  'Furniture and Home Furnishings Stores',
  'Furniture and Related Product Manufacturing',
  'Gasoline Stations',
  'General Merchandise Stores',
  'Goods-Producing Industries',
  'Health Care and Social Assistance',
  'Health and Personal Care Stores',
  'Heavy and Civil Engineering Construction',
  'Hospitals',
  'Information',
  'Insurance Carriers and Related Activities',
  'Internet Publishing and Broadcasting',
  'Leather and Allied Product Manufacturing',
  'Leisure and Hospitality',
  'Lessors of Nonfinancial Intangible Assets (except Copyrighted Works)',
  'Machinery Manufacturing',
  'Management of Companies and Enterprises',
  'Manufacturing',
  'Merchant Wholesalers, Durable Goods',
  'Merchant Wholesalers, Nondurable Goods',
  'Mining',
  'Mining, Quarrying, and Oil and Gas Extraction',
  'Miscellaneous Manufacturing',
  'Miscellaneous Store Retailers',
  'Monetary Authorities - Central Bank',
  'Motion Picture and Sound Recording Industries',
  'Motor Vehicle and Parts Dealers',
  'Museums, Historical Sites, and Similar Institutions',
  'Natural Resources and Mining',
  'Nonmetallic Mineral Product Manufacturing',
  'Nonstore Retailers',
  'Nursing and Residential Care Facilities',
  'Oil and Gas Extraction',
  'Other Information Services',
  'Other Services (except Public Administration)',
  'Paper Manufacturing',
  'Performing Arts, Spectator Sports, and Related Industries',
  'Personal and Laundry Services',
  'Petroleum and Coal Products Manufacturing',
  'Pipeline Transportation',
  'Plastics and Rubber Products Manufacturing',
  'Postal Service',
  'Primary Metal Manufacturing',
  'Printing and Related Support Activities',
  'Private Households',
  'Professional and Business Services',
  'Professional, Scientific, and Technical Services',
  'Publishing Industries (except Internet)',
  'Rail Transportation',
  'Real Estate',
  'Real Estate and Rental and Leasing',
  'Religious, Grantmaking, Civic, Professional, and Similar Organizations',
  'Rental and Leasing Services',
  'Repair and Maintenance',
  'Retail Trade',
  'Scenic and Sightseeing Transportation',
  'Securities, Commodity Contracts, and Other Financial Investments and Related Activities',
  'Service-Providing Industries',
  'Social Assistance',
  'Specialty Trade Contractors',
  'Sporting Goods, Hobby, Book, and Music Stores',
  'Support Activities for Agriculture and Forestry',
  'Support Activities for Mining',
  'Support Activities for Transportation',
  'Telecommunications',
  'Textile Mills',
  'Textile Product Mills',
  'Trade, Transportation, and Utilities',
  'Transit and Ground Passenger Transportation',
  'Transportation Equipment Manufacturing',
  'Transportation and Warehousing',
  'Truck Transportation',
  'Utilities',
  'Warehousing and Storage',
  'Waste Management and Remediation Services',
  'Water Transportation',
  'Wholesale Electronic Markets and Agents and Brokers',
  'Wholesale Trade',
  'Wood Product Manufacturing',
];
