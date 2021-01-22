import 'package:flutter/foundation.dart';
import 'package:sailebot_app/enum/notification_enum.dart';

class NotiObject {
  final String message;
  final String date;
  final NotificationEnum type;
  final bool isRead;

  NotiObject({
    @required this.message,
    @required this.date,
    this.type,
    this.isRead = false,
  });
}
