import 'package:flutter/material.dart';
import 'package:sailebot_app/screens/homes/home_screen.dart';
import 'package:sailebot_app/screens/sailebot/sailebot_setting_screen.dart';
import 'package:sailebot_app/screens/sailebot_swipe/sailebot_swipe_screen.dart';
import 'package:sailebot_app/utils/extension.dart';

enum NotificationEnum {
  wellcome,
  reminderCreateSailebot,
  createdSailebot,
  sailebotLaunched,
  updateSailebot,
  unknown,
}

extension NotificationEnumExt on NotificationEnum {
  String get bgImage {
    switch (this) {
      case NotificationEnum.wellcome:
        return 'assets/images/bg_noti_wellcome.png';
      case NotificationEnum.reminderCreateSailebot:
        return 'assets/images/bg_noti_reminder_sailbot.png';
      case NotificationEnum.createdSailebot:
        return 'assets/images/bg_noti_create_sailebot.png';
      case NotificationEnum.sailebotLaunched:
        return 'assets/images/bg_noti_mobile_launched.png';
      case NotificationEnum.updateSailebot:
        return 'assets/images/bg_noti_update_sailebot.png';
      default:
        return '';
    }
  }

  String get detailNotiMessage {
    switch (this) {
      case NotificationEnum.wellcome:
        return 'Welcome message';
      case NotificationEnum.reminderCreateSailebot:
        return 'You\'ve swiped right 3 times. Create a Sailebot to act upon these opportunities.';
      case NotificationEnum.createdSailebot:
        return 'Your Sailebot has been created. You will receive a notification when our team completes optimizing your Sailebot.';
      case NotificationEnum.sailebotLaunched:
        return 'Your Sailebot has been launched! View your Sailebot Settings to confirm targeting parameters.';
      case NotificationEnum.updateSailebot:
        return 'We\'ve received your request to update your Sailebot. Our team will reach out soon to confirm the update.';
      default:
        return '';
    }
  }

  String get detailNotiButtonTitle {
    switch (this) {
      case NotificationEnum.wellcome:
        return 'Explore Saileswipe'.toUpperCase();
      case NotificationEnum.reminderCreateSailebot:
        return 'Create Sailebot'.toUpperCase();
      case NotificationEnum.createdSailebot:
        return 'Go to Dashboard'.toUpperCase();
      case NotificationEnum.sailebotLaunched:
      case NotificationEnum.updateSailebot:
        return 'Sailebot Settings'.toUpperCase();
      default:
        return '';
    }
  }

  double get ratioImage {
    switch (this) {
      case NotificationEnum.wellcome:
        return 0.721311475;
      case NotificationEnum.updateSailebot:
      case NotificationEnum.sailebotLaunched:
      case NotificationEnum.reminderCreateSailebot:
        return 0.680327869;
      case NotificationEnum.createdSailebot:
        return 0.639344262;
      default:
        return 1;
    }
  }

  void gotoScreen(BuildContext context) {
    switch (this) {
      case NotificationEnum.wellcome:
        context.navigator.pushReplacementNamed(SaileBotSwipeScreen.routeName);
        break;
      case NotificationEnum.reminderCreateSailebot:
        break;
      case NotificationEnum.createdSailebot:
        context.navigator.popUntil((route) {
          bool isPop = false;
          if (route.settings.name == HomeScreen.routeName) {
            isPop = true;
          }

          if (!isPop && !route.navigator.canPop()) {
            route.navigator.pushReplacementNamed(HomeScreen.routeName);
            return true;
          }

          return isPop;
        });

        break;
      case NotificationEnum.updateSailebot:
      case NotificationEnum.sailebotLaunched:
        context.navigator.popUntil((route) {
          bool isPop = false;
          if (route.settings.name == SaileBotSettingScreen.routeName) {
            isPop = true;
          }

          if (!isPop && !route.navigator.canPop()) {
            route.navigator
                .pushReplacementNamed(SaileBotSettingScreen.routeName);
            return true;
          }

          return isPop;
        });

        break;
      default:
        break;
    }
  }
}
