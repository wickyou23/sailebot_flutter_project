import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sailebot_app/enum/answer_enum.dart';
import 'package:sailebot_app/models/answer_object.dart';
import 'package:sailebot_app/models/question_object.dart';

class QuestionViewModel {
  final QuestionObject mainQuestion;
  List<BaseQuestionObject> allQuestion;
  List<AnswerObject> allAnswer;
  String lastInputTypeId;

  String get id {
    return this.mainQuestion.id;
  }

  QuestionViewModel({@required this.mainQuestion}) {
    List<BaseQuestionObject> allQ = [mainQuestion];
    List<AnswerObject> allAns = List<AnswerObject>.from(mainQuestion.anwsers);
    if (mainQuestion.subQuestions.isNotEmpty) {
      for (var item in mainQuestion.subQuestions) {
        allQ.add(item);
        allAns.addAll(item.anwsers);
      }
    }

    for (var i = allAns.length - 1; i >= 0; i--) {
      var element = allAns[i];
      if (element.type == AnswerEnum.inputType ||
          element.type == AnswerEnum.multipleInputType) {
        this.lastInputTypeId = element.id;
        break;
      }
    }

    this.allQuestion = allQ;
    this.allAnswer = allAns;
  }

  void saveAllUserAnswer() {
    this.allAnswer.forEach((element) {
      if (element.tmpUserAnswer != element.userAnswer) {
        element.userAnswer = element.tmpUserAnswer;
      }
    });
  }

  void resetAllUserAnswer() {
    this.allAnswer.forEach((element) {
      element.userAnswer = null;
      element.tmpUserAnswer = null;
    });
  }

  String getNextAnswerId(String currentId) {
    var idx = this.allAnswer.indexWhere((element) => element.id == currentId);
    if (idx != -1) {
      for (var i = idx + 1; i < this.allAnswer.length; i++) {
        var aw = this.allAnswer[i];
        if (aw.type == AnswerEnum.inputType ||
            aw.type == AnswerEnum.multipleInputType) {
          return aw.id;
        }
      }
    }

    return null;
  }
}
