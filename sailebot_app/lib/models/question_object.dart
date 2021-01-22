import 'package:sailebot_app/enum/answer_enum.dart';
import 'package:sailebot_app/models/answer_object.dart';
import 'package:uuid/uuid.dart';

class BaseQuestionObject {
  final String description;
  final String question;
  final List<AnswerObject> anwsers;
  final bool isSkip;
  final bool isOptional;
  final bool forceHideAnswerTitle;
  final String id = Uuid().v4();

  BaseQuestionObject({
    this.description = '',
    this.question,
    this.anwsers = const [],
    this.isSkip = false,
    this.isOptional = false,
    this.forceHideAnswerTitle = false,
  });

  bool get isShowAnswerTitle {
    if (this.forceHideAnswerTitle) return false;
    if (this.anwsers.isNotEmpty) {
      var itAnswer = this.anwsers.first;
      if (itAnswer.type == AnswerEnum.multipleSelectType ||
          itAnswer.type == AnswerEnum.picker) {
        return false;
      }
    }

    return true;
  }

  bool get isAnswerPickerType {
    if (this.anwsers.isNotEmpty) {
      var itAnswer = this.anwsers.first;
      if (itAnswer.type == AnswerEnum.picker) {
        return true;
      }
    }

    return false;
  }
}

class SubQuestionObject extends BaseQuestionObject {
  SubQuestionObject({
    String description = '',
    String question,
    List<AnswerObject> anwsers = const [],
    bool isSkip = false,
    bool isOptional = false,
    bool forceHideAnswerTitle = false,
  }) : super(
          description: description,
          question: question,
          anwsers: anwsers,
          isSkip: isSkip,
          isOptional: isOptional,
          forceHideAnswerTitle: forceHideAnswerTitle,
        );
}

class QuestionObject extends BaseQuestionObject {
  final List<SubQuestionObject> subQuestions;

  QuestionObject({
    String description = '',
    String question,
    List<AnswerObject> anwsers = const [],
    bool isSkip = false,
    bool isOptional = false,
    bool forceHideAnswerTitle = false,
    this.subQuestions = const [],
  }) : super(
          description: description,
          question: question,
          anwsers: anwsers,
          isSkip: isSkip,
          isOptional: isOptional,
          forceHideAnswerTitle: forceHideAnswerTitle,
        );
}
