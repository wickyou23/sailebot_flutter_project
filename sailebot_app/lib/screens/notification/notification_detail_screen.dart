import 'package:flutter/material.dart';
import 'package:sailebot_app/models/notification_object.dart';
import 'package:sailebot_app/utils/utils.dart';
import 'package:sailebot_app/widgets/common_intro_widget.dart';
import 'package:sailebot_app/utils/extension.dart';
import 'package:sailebot_app/widgets/custom_navigation_bar.dart';
import 'package:sailebot_app/enum/notification_enum.dart';

class NotificationDetailScreen extends StatelessWidget {
  static final routeName = '/NotificationDetailScreen';
  final double _heightImage = 216;

  @override
  Widget build(BuildContext context) {
    Utils.homeStatusBar();
    NotiObject _crNoti = context.routeArg as NotiObject;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: CommonIntroWidget(
              assetImage: _crNoti.type.bgImage,
              widthImage: _heightImage,
              ratioImage: _crNoti.type.ratioImage,
              description: _crNoti.type.detailNotiMessage,
              titleButton: _crNoti.type.detailNotiButtonTitle,
              onPressed: () {
                _crNoti.type.gotoScreen(context);
              },
            ),
          ),
          CustomNavigationBar(
            navTitle: '',
            tintColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
