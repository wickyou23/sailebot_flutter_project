import 'dart:convert';
import 'package:sailebot_app/enum/question_section_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStoreService {
  static final LocalStoreService _shared = LocalStoreService._internal();

  SharedPreferences _sharedPrefer;

  LocalStoreService._internal();

  factory LocalStoreService() {
    return _shared;
  }

  Future<void> config() async {
    _sharedPrefer = await SharedPreferences.getInstance();
  }

  set isSignIn(bool newIsSignIn) {
    if (newIsSignIn == null) {
      _sharedPrefer.remove('isSignIn');
    } else {
      _sharedPrefer.setBool('isSignIn', newIsSignIn);
    }
  }

  bool get isSignIn {
    return _sharedPrefer.getBool('isSignIn') ?? false;
  }

  set isSaveProfile(bool newIsSaveProfile) {
    if (newIsSaveProfile == null) {
      _sharedPrefer.remove('isSaveProfile');
    } else {
      _sharedPrefer.setBool('isSaveProfile', newIsSaveProfile);
    }
  }

  bool get isSaveProfile {
    return _sharedPrefer.getBool('isSaveProfile') ?? false;
  }

  set swipeNumberStack(int newNumberStack) {
    if (newNumberStack == null) {
      _sharedPrefer.remove('numberStack');
    } else {
      _sharedPrefer.setInt('numberStack', newNumberStack);
    }
  }

  int get swipeNumberStack {
    return _sharedPrefer.getInt('numberStack') ?? 1;
  }

  set swipeNumberSwipeRight(int newNumberSwipeRight) {
    if (newNumberSwipeRight == null) {
      _sharedPrefer.remove('numberSwipeRight');
    } else {
      _sharedPrefer.setInt('numberSwipeRight', newNumberSwipeRight);
    }
  }

  int get swipeNumberSwipeRight {
    return _sharedPrefer.getInt('numberSwipeRight') ?? 0;
  }

  set swipeIsFirstSwipeRightThreeTime(bool newIsFirstSwipeRightThreeTime) {
    if (newIsFirstSwipeRightThreeTime == null) {
      _sharedPrefer.remove('isFirstSwipeRightThreeTime');
    } else {
      _sharedPrefer.setBool(
          'isFirstSwipeRightThreeTime', newIsFirstSwipeRightThreeTime);
    }
  }

  bool get swipeIsFirstSwipeRightThreeTime {
    return _sharedPrefer.getBool('isFirstSwipeRightThreeTime') ?? false;
  }

  set swipeDate(int newSwipeDate) {
    if (newSwipeDate == null) {
      _sharedPrefer.remove('swipeDate');
    } else {
      _sharedPrefer.setInt('swipeDate', newSwipeDate);
    }
  }

  int get swipeDate {
    return _sharedPrefer.getInt('swipeDate');
  }

  set isSetupSailebot(bool newIsSetupSailebot) {
    if (newIsSetupSailebot == null) {
      _sharedPrefer.remove('isSetupSailebot');
    } else {
      _sharedPrefer.setBool('isSetupSailebot', newIsSetupSailebot);
    }
  }

  bool get isSetupSailebot {
    return _sharedPrefer.getBool('isSetupSailebot') ?? false;
  }

  set currentQuestionSetup(
      Map<QuestionSectionEnum, int> newCurrentQuestionSetup) {
    if (newCurrentQuestionSetup == null) {
      _sharedPrefer.remove('currentQuestionSetup');
    } else {
      Map<String, int> cache = {};
      newCurrentQuestionSetup.forEach((key, value) {
        cache[key.rawValue] = value;
      });

      String jsonString = JsonEncoder().convert(cache);
      _sharedPrefer.setString('currentQuestionSetup', jsonString);
    }
  }

  Map<QuestionSectionEnum, int> get currentQuestionSetup {
    String jsonString = _sharedPrefer.getString('currentQuestionSetup');
    if (jsonString == null) return null;

    dynamic jsonObj = JsonDecoder().convert(jsonString);
    Map<QuestionSectionEnum, int> rs = {};
    if (jsonObj is Map) {
      jsonObj.forEach((key, value) {
        var qEnum = QuestionSectionEnumExt.initWithRawValue(key as String);
        if (qEnum != null) {
          rs[qEnum] = value;
        }
      });
    }

    if (rs.isEmpty) return null;
    return rs;
  }

  void removeAllCache() {
    _sharedPrefer.clear();
  }

  void removeQuestionCache() {
    _sharedPrefer.remove('currentQuestionSetup');
  }
}
