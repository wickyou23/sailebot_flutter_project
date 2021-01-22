import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:sailebot_app/services/navite_email_service.dart';
import 'package:sailebot_app/widgets/custom_navigation_bar.dart';
import 'package:sailebot_app/utils/extension.dart';

class PreviewDevelopingScreen extends StatefulWidget {
  static final routeName = '/PreviewDevelopingScreen';

  @override
  _PreviewDevelopingScreenState createState() =>
      _PreviewDevelopingScreenState();
}

class _PreviewDevelopingScreenState extends State<PreviewDevelopingScreen> {
  final String _demoText =
      'Dear Mr Daves,\nNulla est nostrud ea reprehenderit duis nostrud cillum. Ullamco sit dolore aliqua in tempor adipisicing do est consectetur. Sit fugiat laboris pariatur elit aliqua non adipisicing aute velit qui. Fugiat eiusmod eiusmod ut et veniam velit aliquip sunt.\n\nNulla est nostrud ea reprehenderit duis nostrud.\n\nIt is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).';
  double _remindHeight = -1;
  bool _isHideShowMore = true;

  @override
  void didChangeDependencies() {
    _caculatorMessageTextHeight();
    super.didChangeDependencies();
  }

  void _caculatorMessageTextHeight() {
    double _naviH =
        context.media.viewPadding.top + CustomNavigationBar.heightNavBar;
    double _infoH = 170;
    double _bottomH = context.media.viewPadding.bottom == 0
        ? 20
        : context.media.viewPadding.bottom;
    double _showMoreH = 50;
    double _dateH = 75;
    double _msgH = Text(
      _demoText,
      style: context.theme.textTheme.headline5.copyWith(
        color: ColorExt.myBlack,
        fontSize: 14,
        height: 1.5,
      ),
    ).getTextSize(context.media.size.width - 50).height;
    double _remindH =
        context.media.size.height - _naviH - _infoH - _bottomH - _dateH;
    if (_remindH <= 200) {
      _isHideShowMore = true;
      return;
    }

    if (_msgH > _remindH) {
      _isHideShowMore = false;
      _remindHeight = _remindH - _showMoreH - 16;
    } else {
      _isHideShowMore = true;
      _remindHeight = _remindH;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            height: context.media.size.height / 2,
            color: ColorExt.colorWithHex(0x098EF5),
          ),
          Container(
            margin: EdgeInsets.only(
              top: context.media.viewPadding.top +
                  CustomNavigationBar.heightNavBar,
            ),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: context.media.size.height -
                      (context.media.viewPadding.top +
                          CustomNavigationBar.heightNavBar),
                ),
                child: IntrinsicHeight(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                            right: 25,
                            left: 25,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                ColorExt.colorWithHex(0x098EF5),
                                ColorExt.colorWithHex(0x098EF5),
                                ColorExt.colorWithHex(0x12B3FF),
                              ],
                            ),
                          ),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                _columnItem('Name', 'Daves Mustaine'),
                                _columnItem('Company', 'Megadeth'),
                                _columnItem('Revenue', '\$ 1,000,000'),
                                _columnItem('Employees', '5'),
                                _columnItem('Digital Labor', '10'),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 60,
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.only(left: 25, right: 25),
                          child: Row(
                            children: <Widget>[
                              Text(
                                '11:30 am, May 14, 2020 (1 day ago)',
                                style:
                                    context.theme.textTheme.subtitle2.copyWith(
                                  color: Colors.grey[800],
                                  fontSize: 11,
                                ),
                                maxLines: 2,
                              ),
                              Expanded(child: Container()),
                              SizedBox(width: 8),
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                child: Image.asset(
                                  'assets/images/ic_share_circle.png',
                                  width: 42,
                                  height: 42,
                                  fit: BoxFit.cover,
                                ),
                                onPressed: () {
                                  _handleSendMail();
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 25, right: 25),
                          constraints: (_isHideShowMore)
                              ? BoxConstraints(minHeight: _remindHeight)
                              : BoxConstraints(maxHeight: _remindHeight),
                          child: Text(
                            _demoText,
                            style: context.theme.textTheme.headline5.copyWith(
                              color: ColorExt.myBlack,
                              fontSize: 14,
                              height: 1.5,
                            ),
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                        Expanded(child: Container()),
                        if (!_isHideShowMore)
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: ColorExt.mainColor,
                                width: 1,
                              ),
                            ),
                            child: FlatButton(
                              onPressed: () {
                                _isHideShowMore = true;
                                setState(() {});
                              },
                              child: Text(
                                'SHOW MORE',
                                style:
                                    context.theme.textTheme.headline6.copyWith(
                                  color: ColorExt.colorWithHex(0x098EF5),
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        SizedBox(
                          height: context.media.viewPadding.bottom == 0
                              ? 20
                              : context.media.viewPadding.bottom,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          CustomNavigationBar(
            navTitle: 'Delivered',
            backgroundColor: ColorExt.colorWithHex(0x098EF5),
          ),
        ],
      ),
    );
  }

  Widget _columnItem(String title, String desc) {
    return Container(
      height: 30,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: context.theme.textTheme.headline6.copyWith(
                fontSize: 13,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              desc,
              style: context.theme.textTheme.headline5.copyWith(
                fontSize: 19,
                color: Colors.white,
              ),
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
      recipients: ['davesmustaine@saile.ai'],
    );

    if (Platform.isIOS) {
      await NativeEmailService().sendEmail(email);
    } else {
      await FlutterEmailSender.send(email);
    }
  }
}
