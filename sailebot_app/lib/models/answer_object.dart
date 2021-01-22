import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sailebot_app/enum/answer_enum.dart';
import 'package:uuid/uuid.dart';

class AnswerObject {
  final AnswerEnum type;
  final List<String> sugestionAnswer;
  final String placeHolder;
  final int columnForMultipleSelected;
  final String id = Uuid().v4();
  final TextInputType inputType;

  dynamic tmpUserAnswer;
  dynamic userAnswer;

  AnswerObject({
    @required this.type,
    this.sugestionAnswer = const [],
    this.placeHolder,
    this.columnForMultipleSelected = 3,
    this.inputType = TextInputType.text
  });
}
