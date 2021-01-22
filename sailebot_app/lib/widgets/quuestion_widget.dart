import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sailebot_app/data/view_model/question_vm.dart';
import 'package:sailebot_app/enum/answer_enum.dart';
import 'package:sailebot_app/enum/text_field_enum.dart';
import 'package:sailebot_app/models/answer_object.dart';
import 'package:sailebot_app/models/question_object.dart';
import 'package:sailebot_app/services/questionaire_service.dart';
import 'package:sailebot_app/utils/extension.dart';
import 'package:sailebot_app/widgets/search_box_widget.dart';
import 'custom_textformfield.dart';

class QuestionWidget extends StatefulWidget {
  final Key key;
  final QuestionViewModel q;
  final Function saveOnPressed;
  final Function nextOnPressed;
  final Function skipOnPressed;

  QuestionWidget({
    @required this.key,
    @required this.q,
    @required this.saveOnPressed,
    @required this.nextOnPressed,
    this.skipOnPressed,
  }) : super(key: key);

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  Map<String, TextEditingController> _textEditing = {};
  Map<String, FocusNode> _textFC = {};
  Map<String, ValueKey> _ansKey = {};
  Map<String, FixedExtentScrollController> _pickerScrollKey = {};
  QuestionViewModel get q {
    return this.widget.q;
  }

  @override
  void initState() {
    this.q.allAnswer.forEach((element) {
      element.tmpUserAnswer = element.userAnswer;
    });
    super.initState();
  }

  @override
  void dispose() {
    debugPrint('QuestionWidget ${this.q.id} dispose======================');
    _textFC.forEach((key, value) {
      value.dispose();
    });

    _textEditing.forEach((key, value) {
      value.dispose();
    });

    _textEditing = {};
    _textFC = {};

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: _buildWidgets(),
    );
  }

  List<Widget> _buildWidgets() {
    List<Widget> widgets = [];
    widgets.add(SizedBox(height: 20));
    for (var item in this.q.allQuestion) {
      widgets.addAll(_buildQuestionWidget(item));
      widgets.add(SizedBox(height: 20));
    }

    widgets.removeLast();
    widgets.addAll([
      SizedBox(height: 44),
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                height: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: FlatButton(
                    child: Text(
                      'SAVE',
                      style: context.theme.textTheme.button.copyWith(
                        color: context.theme.primaryColor,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: ColorExt.colorWithHex(0x098EF5),
                        width: 1.0,
                      ),
                    ),
                    color: Colors.transparent,
                    onPressed: () {
                      this.widget.saveOnPressed();
                    },
                  ),
                ),
              ),
            ),
            SizedBox(width: 30),
            Expanded(
              child: Container(
                height: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: RaisedButton(
                    child: Text(
                      'NEXT',
                      style: context.theme.textTheme.button.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    color: ColorExt.colorWithHex(0x098EF5),
                    onPressed: () {
                      this.q.saveAllUserAnswer();
                      this.widget.nextOnPressed();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ]);

    widgets.addAll(_buildSkipButton());
    widgets.add(SizedBox(height: 20));
    return widgets;
  }

  List<Widget> _buildQuestionWidget(BaseQuestionObject qObj) {
    return <Widget>[
      if (qObj.isOptional) ...[
        Text(
          '(Optional)',
          style: TextStyle(
            fontFamily: 'Sarabun',
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: ColorExt.colorWithHex(0x828282),
          ),
        ),
        SizedBox(height: 16),
      ],
      if (qObj.description != null && qObj.description.isNotEmpty) ...[
        Text(
          qObj.description,
          style: qObj.isAnswerPickerType
              ? context.theme.textTheme.subtitle1.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                )
              : context.theme.textTheme.headline5.copyWith(
                  fontSize: 19,
                  height: 1.5,
                ),
          textAlign:
              qObj.isAnswerPickerType ? TextAlign.center : TextAlign.left,
        ),
        SizedBox(height: 30),
      ],
      if (qObj.isAnswerPickerType) SizedBox(height: 40),
      Text(
        qObj.question,
        style: qObj.isAnswerPickerType
            ? context.theme.textTheme.subtitle1.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              )
            : context.theme.textTheme.headline5.copyWith(
                fontSize: 19,
                height: 1.5,
              ),
        textAlign: qObj.isAnswerPickerType ? TextAlign.center : TextAlign.left,
      ),
      if (qObj.isShowAnswerTitle) ...[
        SizedBox(height: 20),
        Text(
          'Answer',
          style: context.theme.textTheme.headline5.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
      ..._buildAnswer(qObj),
    ];
  }

  List<Widget> _buildAnswer(BaseQuestionObject qObj) {
    List<Widget> widgets = [];
    for (var item in qObj.anwsers) {
      widgets.add(SizedBox(height: 16));
      widgets.add(_buildAnswerItem(item));
    }

    if (qObj.isAnswerPickerType) {
      widgets.removeAt(0);
    }

    return widgets;
  }

  Widget _buildAnswerItem(AnswerObject aw, {Function(dynamic) completed}) {
    Key tfKey;
    if (_ansKey[aw.id] != null) {
      tfKey = _ansKey[aw.id];
    } else {
      tfKey = ValueKey(aw.id);
      _ansKey[aw.id] = tfKey;
    }

    TextEditingController controller;
    FocusNode focus;
    if (aw.type == AnswerEnum.selectType ||
        aw.type == AnswerEnum.inputType ||
        aw.type == AnswerEnum.multipleInputType ||
        aw.type == AnswerEnum.industrySearchBox) {
      controller = TextEditingController(text: aw.tmpUserAnswer);
      focus = FocusNode();
      if (_textEditing[aw.id] != null) {
        controller = _textEditing[aw.id];
      } else {
        _textEditing[aw.id] = controller;
      }

      if (_textFC[aw.id] != null) {
        focus = _textFC[aw.id];
      } else {
        _textFC[aw.id] = focus;
      }
    }

    switch (aw.type) {
      case AnswerEnum.selectType:
        return CustomTextFormField(
          key: tfKey,
          controller: controller,
          focusNode: focus,
          placeHolder: 'Select one',
          readOnly: true,
          textFieldStyle: CustomTextFormFieldType.normalStyle,
          suffixIcon: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.black,
          ),
          onTap: () {
            context.showBottomSheet(
              aw.sugestionAnswer,
              controller.text,
              (vl) {
                controller.text = vl;
                aw.tmpUserAnswer = vl;
                Future.delayed(Duration(milliseconds: 50), () {
                  focus.unfocus();
                });
              },
            ).then((_) {
              Future.delayed(Duration(milliseconds: 50), () {
                focus.unfocus();
              });
            });
          },
        );
      case AnswerEnum.industrySearchBox:
        return CustomTextFormField(
          key: tfKey,
          controller: controller,
          focusNode: focus,
          placeHolder: 'Select one',
          readOnly: true,
          keyboardType: TextInputType.multiline,
          maxLine: null,
          textFieldStyle: CustomTextFormFieldType.normalStyle,
          suffixIcon: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.black,
          ),
          onTap: () {
            var allTmpAnswer = q.allAnswer
                .where((element) => element.id != aw.id)
                .map((e) => e.tmpUserAnswer as String)
                .toList();
            var _industries = QuestionaireService()
                .getIndustries()
                .where((element) => !allTmpAnswer.contains(element))
                .toList();
            context
                .showPopup(
              child: SearchBoxWidget(
                _industries,
                itemSelected: aw.tmpUserAnswer as String,
                onSelected: (itemSeleted) {
                  controller.text = itemSeleted;
                  aw.tmpUserAnswer = itemSeleted;
                  Future.delayed(Duration(milliseconds: 50), () {
                    focus.unfocus();
                  });
                },
              ),
            )
                .then((_) {
              Future.delayed(Duration(milliseconds: 50), () {
                focus.unfocus();
              });
            });
          },
        );
      case AnswerEnum.inputType:
      case AnswerEnum.multipleInputType:
        return CustomTextFormField(
          key: tfKey,
          controller: controller,
          focusNode: focus,
          placeHolder: aw.placeHolder ?? 'Type your answer here',
          textFieldStyle: CustomTextFormFieldType.normalStyle,
          textInputAction: (aw.type == AnswerEnum.multipleInputType)
              ? TextInputAction.newline
              : TextInputAction.next,
          keyboardType: (aw.type == AnswerEnum.multipleInputType)
              ? TextInputType.multiline
              : aw.inputType,
          maxLine: (aw.type == AnswerEnum.multipleInputType) ? 5 : 1,
          onChanged: (vl) {
            aw.tmpUserAnswer = vl;
          },
          onFieldSubmitted: (vl) {
            context.focus.unfocus();
            if (this.q.lastInputTypeId != aw.id) {
              var nextAwId = this.q.getNextAnswerId(aw.id);
              if (nextAwId != null) {
                var focus = _textFC[nextAwId];
                if (focus != null) {
                  context.focus.requestFocus(focus);
                }
              }
            }
          },
        );
      case AnswerEnum.multipleSelectType:
        var widthCell =
            (context.media.size.width - 40) / aw.columnForMultipleSelected;
        var heightCell = 37;
        var mode = aw.sugestionAnswer.length % aw.columnForMultipleSelected;
        var line = aw.sugestionAnswer.length / aw.columnForMultipleSelected;
        var height = ((mode == 0) ? line : line + 1) * heightCell;
        var userAns = aw.tmpUserAnswer as List<String> ?? List<String>();
        return Container(
          height: height,
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: aw.sugestionAnswer.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: aw.columnForMultipleSelected,
              childAspectRatio: widthCell / heightCell,
            ),
            itemBuilder: (ctx, index) {
              var answer = aw.sugestionAnswer[index];
              return Row(
                children: <Widget>[
                  Transform.scale(
                    scale: 1.1,
                    child: Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: userAns.contains(answer),
                      onChanged: (checked) {
                        if (checked) {
                          userAns.add(answer);
                        } else {
                          userAns.remove(answer);
                        }

                        aw.tmpUserAnswer = userAns;
                        setState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    child: Text(
                      answer,
                      style: context.theme.textTheme.subtitle1.copyWith(
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      case AnswerEnum.picker:
        FixedExtentScrollController fixedScrollController =
            _pickerScrollKey[aw.id];
        int selectedIndex = aw.sugestionAnswer.indexOf(aw.tmpUserAnswer) ?? 0;
        if (fixedScrollController == null) {
          fixedScrollController =
              FixedExtentScrollController(initialItem: selectedIndex);
          _pickerScrollKey[aw.id] = fixedScrollController;
        } else {
          fixedScrollController.jumpToItem(selectedIndex);
        }

        return Align(
          alignment: Alignment.center,
          child: Container(
            height: 220,
            width: 250,
            child: CupertinoPicker.builder(
              scrollController: fixedScrollController,
              childCount: aw.sugestionAnswer.length,
              itemExtent: 50,
              onSelectedItemChanged: (index) {
                aw.tmpUserAnswer = aw.sugestionAnswer[index];
              },
              itemBuilder: (context, index) {
                return Container(
                  alignment: Alignment.center,
                  child: Text(
                    aw.sugestionAnswer[index],
                    textAlign: TextAlign.center,
                    style: context.theme.textTheme.headline5.copyWith(
                      fontSize: 19,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      default:
        return null;
    }
  }

  List<Widget> _buildSkipButton() {
    if (!q.mainQuestion.isSkip) return [];
    List<Widget> widgets = [];
    widgets.add(SizedBox(height: 20));
    widgets.add(Expanded(child: Container()));
    widgets.add(CupertinoButton(
      child: Text(
        'SKIP',
        style: context.theme.textTheme.headline6.copyWith(
          color: ColorExt.colorWithHex(0x098EF5),
          fontSize: 17,
        ),
      ),
      onPressed: () {
        q.resetAllUserAnswer();
        this.widget.skipOnPressed();
      },
    ));
    return widgets;
  }
}
