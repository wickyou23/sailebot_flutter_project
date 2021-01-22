import 'dart:math';

import 'package:intl/intl.dart' as intl;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sailebot_app/utils/constant.dart';

extension BuildContextExt on BuildContext {
  ThemeData get theme {
    return Theme.of(this);
  }

  MediaQueryData get media {
    return MediaQuery.of(this);
  }

  NavigatorState get navigator {
    return Navigator.of(this);
  }

  ModalRoute get route {
    return ModalRoute.of(this);
  }

  Object get routeArg {
    return this.route.settings.arguments;
  }

  bool get isSmallDevice {
    return this.media.size.height < 600;
  }

  double get scaleDevice {
    return this.isSmallDevice ? 0.8 : 1.0;
  }

  FocusScopeNode get focus {
    return FocusScope.of(this);
  }

  Future<bool> showAlertConfirm({String message}) {
    return showDialog<bool>(
      barrierDismissible: false,
      context: this,
      builder: (ctx) {
        return AlertDialog(
          title: Container(
            height: 50,
            width: this.media.size.width,
            color: Colors.redAccent,
            alignment: AlignmentDirectional.centerStart,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.warning,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  'Confirm',
                  style: this.theme.textTheme.headline6.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                ),
              ],
            ),
          ),
          titlePadding: EdgeInsets.zero,
          content: Text(
            message ?? 'Do you to remove this item?',
            style: this.theme.textTheme.headline6.copyWith(
                  fontSize: 20,
                ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'CANCEL',
                style: this.theme.textTheme.headline6.copyWith(
                      fontSize: 15,
                      color: this.theme.primaryColor,
                    ),
              ),
              onPressed: () {
                this.navigator.pop(false);
              },
            ),
            RaisedButton(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              color: Colors.redAccent,
              child: Text(
                'DELETE',
                style: this.theme.textTheme.headline6.copyWith(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              onPressed: () {
                this.navigator.pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> showAlert({String message}) {
    return showDialog<bool>(
      barrierDismissible: false,
      context: this,
      builder: (ctx) {
        return AlertDialog(
          titlePadding: EdgeInsets.zero,
          content: Text(
            message,
            style: this.theme.textTheme.headline6.copyWith(
                  fontSize: 20,
                ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'OK',
                style: this.theme.textTheme.headline6.copyWith(
                      fontSize: 15,
                      color: this.theme.primaryColor,
                    ),
              ),
              onPressed: () {
                this.navigator.pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> showLoadingAlert({String message}) {
    return showDialog<bool>(
      barrierDismissible: false,
      context: this,
      builder: (ctx) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: AlertDialog(
            contentPadding: const EdgeInsets.only(top: 20, bottom: 16),
            titlePadding: EdgeInsets.zero,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  message,
                  style: this.theme.textTheme.headline6.copyWith(
                        fontSize: 17,
                      ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showBottomSheet(
    List<String> data,
    String selectedData,
    Function(String) completed,
  ) {
    showModalBottomSheet(
      context: this,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      builder: (BuildContext ctx) {
        return Container(
          height: (data.length.toDouble() * 50) + 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ListView.separated(
            itemBuilder: (ctx, idx) {
              var item = data[idx];
              return Container(
                height: 50,
                child: ListTile(
                  key: ValueKey(item),
                  title: Text(
                    item,
                    style: ctx.theme.textTheme.headline5.copyWith(
                      fontSize: 18,
                      color: ColorExt.myBlack,
                    ),
                  ),
                  trailing: (selectedData == item)
                      ? Icon(
                          Icons.check,
                          color: ColorExt.mainColor,
                          size: 20,
                        )
                      : Container(
                          width: 1,
                        ),
                  onTap: () {
                    completed(item);
                    this.navigator.pop();
                  },
                ),
              );
            },
            separatorBuilder: (_, idx) {
              return Divider(
                height: 0.5,
                color: Colors.grey[400],
                indent: 16,
              );
            },
            itemCount: data.length,
          ),
        );
      },
    );
  }
}

extension DateTimeExt on DateTime {
  String csToString(String formatString) {
    var format = intl.DateFormat(formatString);
    return format.format(this);
  }

  DateTime startOfDate() {
    return DateTime(this.year, this.month, this.day);
  }

  DateTime endOfDate() {
    return DateTime(this.year, this.month, this.day, 23, 59, 59);
  }

  bool isToday() {
    DateTime now = DateTime.now();
    return now.year == this.year && now.month == this.month && now.day == this.day;
  }

  //Start at Monday
  static List<DateTime> dateInWeekByDate(DateTime date) {
    final now = DateTime.now().startOfDate();
    final weekDay = date.weekday;
    final result = <DateTime>[];
    for (var i = 1; i <= 7; i++) {
      final calculate = now.add(Duration(days: i - weekDay));
      result.add(calculate);
    }

    return result;
  }
}

extension IterableExt on Iterable {
  Iterable shift(int number) {
    if (number <= 0) {
      return this;
    }

    final sub = this.length - number;
    return Iterable.generate(this.length, (index) {
      if (sub + index < this.length) {
        return this.elementAt(sub + index);
      } else {
        return this.elementAt(index - number);
      }
    });
  }
}

extension MediaQueryDataExt on MediaQueryData {
  double get contentHeight {
    return this.size.height - this.padding.top;
  }
}

extension ColorExt on Color {
  Color withPercentAlpha(double percent) {
    if (percent >= 1) {
      return this;
    }

    return this.withAlpha((255 * percent).toInt());
  }

  static Color get mainColor {
    return Constaint.mainColor;
  }

  static Color colorWithHex(int hexColor) {
    return Color.fromARGB(
      0xFF,
      (hexColor >> 16) & 0xFF,
      (hexColor >> 8) & 0xFF,
      hexColor & 0xFF,
    );
  }

  static Color get myBlack {
    return ColorExt.colorWithHex(0x2C2C2C);
  }
}

extension TextExt on Text {
  Size get textSize {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: this.data, style: this.style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  Size getTextSize(double width) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: this.data, style: this.style),
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: width);
    return textPainter.size;
  }
}

extension DoubleExt on double {
  double toRadian() {
    return (this * pi) / 180;
  }
}
