import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:sailebot_app/services/navite_call_service.dart';
import 'package:sailebot_app/services/navite_email_service.dart';
import 'package:sailebot_app/utils/extension.dart';
import 'package:sailebot_app/utils/utils.dart';
import 'package:sailebot_app/widgets/custom_navigation_bar.dart';
import 'package:sailebot_app/widgets/home_navigation_bar.dart';

class SupportScreen extends StatefulWidget {
  static final routeName = '/SupportScreen';

  @override
  _SupportScreenState createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    Utils.authAppStatusBar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          CustomNavigationBar(
            backgroundColor: ColorExt.colorWithHex(0x098EF5),
            navTitle: 'Contact Support',
          ),
          Container(
            padding: EdgeInsets.only(
              top:
                  context.media.viewPadding.top + HomeNaviBar.heightNavBar + 50,
            ),
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/images/bg_contact_support.png',
                  fit: BoxFit.cover,
                  width: 170,
                  height: 170 * 0.686813187,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                  child: Text(
                    'Please include your Sailebot ID in your\nemail/message.',
                    textAlign: TextAlign.center,
                    style: context.theme.textTheme.headline5.copyWith(
                      fontSize: 14,
                      color: Colors.grey[900],
                      height: 1.3,
                    ),
                  ),
                ),
                Container(
                  height: 95,
                  width: context.media.size.width,
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: ColorExt.colorWithHex(0xEBF8FF),
                  ),
                  child: FlatButton(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/ic_email.png',
                          width: 25,
                          height: 25,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'support@saile.ai',
                          style: context.theme.textTheme.headline5.copyWith(
                            fontSize: 14,
                            color: Colors.grey[900],
                          ),
                        ),
                      ],
                    ),
                    onPressed: () async {
                      _handleSendMail();
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 95,
                  width: context.media.size.width,
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: ColorExt.colorWithHex(0xEBF8FF),
                  ),
                  child: FlatButton(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/ic_phone_call.png',
                          width: 25,
                          height: 25,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          '+1 202 555 0156',
                          style: context.theme.textTheme.headline5.copyWith(
                            fontSize: 14,
                            color: Colors.grey[900],
                          ),
                        ),
                      ],
                    ),
                    onPressed: () async {
                      try {
                        await NativeCallService()
                            .callPhoneNumber('+12025550156');
                      } catch (e) {
                        _scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            content: Text(
                              'Make call failed',
                              textAlign: TextAlign.center,
                              style: context.theme.textTheme.headline5
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleSendMail() async {
    final Email email = Email(
      body: '',
      subject: '',
      recipients: ['support@saile.ai'],
    );

    if (Platform.isIOS) {
      await NativeEmailService().sendEmail(email);
    } else {
      await FlutterEmailSender.send(email);
    }
  }
}
