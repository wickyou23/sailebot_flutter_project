import 'package:flutter/material.dart';
import 'package:sailebot_app/screens/menu/left_menu_screen.dart';
import 'package:sailebot_app/screens/notification/notification_screen.dart';
import 'package:sailebot_app/screens/sailebot_setup/intro_questionaire_screen.dart';
import 'package:sailebot_app/services/questionaire_service.dart';
import 'package:sailebot_app/utils/utils.dart';
import 'package:sailebot_app/utils/extension.dart';
import 'package:sailebot_app/widgets/custom_navigation_bar.dart';
import 'package:sailebot_app/widgets/home_navigation_bar.dart';

class SaileBotSetupConfirmScreen extends StatefulWidget {
  static final routeName = '/SaileBotSetupConfirmScreen';
  final bool shouldShowBuildSailebotFirst;
  final bool isPush;

  SaileBotSetupConfirmScreen({
    this.shouldShowBuildSailebotFirst = false,
    this.isPush = false,
  });

  @override
  _SaileBotSetupConfirmScreen createState() => _SaileBotSetupConfirmScreen();
}

class _SaileBotSetupConfirmScreen extends State<SaileBotSetupConfirmScreen> {
  final double _widthImage = 260;
  Widget _mainPage;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    Utils.homeStatusBar();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (this.widget.shouldShowBuildSailebotFirst) {
      _mainPage = _beginBuildSaileBotPage();
    } else {
      _mainPage = _confirmSetupSaileBot();
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Container(
        width: context.media.size.width * 0.77,
        child: Drawer(
          child: LeftMenuScreen(
            itemSelected: MenuEnum.home,
            goBackHandler: () {
              Future.delayed(Duration(milliseconds: 100), () {
                Utils.homeStatusBar();
              });
            },
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          _setupNaviBar(),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(
              top: context.media.viewPadding.top,
            ),
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 250),
              child: _mainPage,
            ),
          ),
        ],
      ),
    );
  }

  Widget _confirmSetupSaileBot() {
    return Padding(
      padding: EdgeInsets.only(top: (context.isSmallDevice ? 60 : 100)),
      child: Column(
        key: ValueKey('_confirmSetupSaileBot'),
        children: <Widget>[
          Container(
            child: Image.asset(
              'assets/images/bg_first_setup_bot.png',
              fit: BoxFit.cover,
              width: _widthImage,
              height: 0.6393442623 * _widthImage,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(
              top: context.isSmallDevice ? 0 : 25.0,
              left: 25.0,
              right: 25.0,
              bottom: 25.0,
            ),
            child: Text(
              'Sailebots generate actionable revenue opportunities, with approved prospects, using AI, automation, and the personality traits of human sales executives. Sailebots are paid for performance.',
              style: context.theme.textTheme.headline5.copyWith(
                color: Colors.grey[900],
                fontSize: 19,
                height: 1.3,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(child: Container()),
          Container(
            height: 110 + context.media.viewPadding.bottom,
            margin: context.media.viewPadding.bottom == 0
                ? EdgeInsets.only(bottom: 10)
                : EdgeInsets.zero,
            child: Column(
              children: <Widget>[
                SizedBox(height: 8),
                Text(
                  'Have you set up a Sailebot?',
                  style: context.theme.textTheme.headline6.copyWith(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 140,
                        height: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: FlatButton(
                            child: Text(
                              'YES',
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
                              setState(() {
                                _mainPage = _launchSaileBotPage();
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Container(
                        width: 140,
                        height: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: RaisedButton(
                            child: Text(
                              'NO',
                              style: context.theme.textTheme.button.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            color: ColorExt.colorWithHex(0x098EF5),
                            onPressed: () {
                              setState(() {
                                _mainPage = _beginBuildSaileBotPage();
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _beginBuildSaileBotPage() {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        key: ValueKey('_beginBuildSaileBotPage'),
        children: <Widget>[
          Container(
            child: Image.asset(
              'assets/images/bg_build_bot.png',
              fit: BoxFit.cover,
              width: _widthImage,
              height: 0.6885245902 * _widthImage,
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Text(
              'Let\'s Saile!\nBuild a Sailebot to get started.',
              style: context.theme.textTheme.headline5.copyWith(
                color: Colors.grey[900],
                fontSize: 19,
                height: 1.3,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 30),
          Container(
            width: context.media.size.width - 50,
            height: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: RaisedButton(
                child: Text(
                  'BUILD SAILEBOT',
                  style: context.theme.textTheme.button.copyWith(
                    color: Colors.white,
                  ),
                ),
                color: ColorExt.colorWithHex(0x098EF5),
                onPressed: () {
                  QuestionaireService().startQuestionaire(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _launchSaileBotPage() {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Column(
        key: ValueKey('_launchSaileBotPage'),
        children: <Widget>[
          Container(
            child: Image.asset(
              'assets/images/bg_launch_saile_bot.png',
              fit: BoxFit.fitWidth,
              width: _widthImage,
              height: 0.6393442623 * _widthImage,
            ),
          ),
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Text(
              'Great to hear. Let\'s give your Sailebot an upgrade!',
              style: context.theme.textTheme.headline5.copyWith(
                color: Colors.grey[900],
                fontSize: 19,
                height: 1.3,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 30),
          Container(
            width: context.media.size.width - 50,
            height: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: RaisedButton(
                child: Text(
                  'UPGRADE SAILEBOT',
                  style: context.theme.textTheme.button.copyWith(
                    color: Colors.white,
                  ),
                ),
                color: ColorExt.colorWithHex(0x098EF5),
                onPressed: () {
                  context.navigator
                      .pushNamed(IntroQuestionaireScreen.routeName);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _setupNaviBar() {
    if (this.widget.isPush) {
      return CustomNavigationBar(
        navTitle: '',
        tintColor: ColorExt.myBlack,
      );
    } else {
      return HomeNaviBar(
        drawerPressed: () {
          _scaffoldKey.currentState.openDrawer();
        },
        notiPressed: () {
          context.navigator.pushNamed(NotificationScreen.routeName);
        },
      );
    }
  }

  // Widget _confirmLaunchSaileBotPage() {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 100),
  //     child: Column(
  //       key: ValueKey('_confirmLaunchSaileBotPage'),
  //       children: <Widget>[
  //         Container(
  //           child: Image.asset(
  //             'assets/images/bg_launch_sailebot_confirm.png',
  //             fit: BoxFit.cover,
  //             width: _widthImage,
  //             height: 0.6393442623 * _widthImage,
  //           ),
  //         ),
  //         SizedBox(height: 30),
  //         Padding(
  //           padding: const EdgeInsets.all(25.0),
  //           child: Text(
  //             'All done! Your Sailebot should be set to saile soon!',
  //             style: context.theme.textTheme.headline5
  //                 .copyWith(color: Colors.grey[900]),
  //             textAlign: TextAlign.center,
  //           ),
  //         ),
  //         SizedBox(height: 30),
  //         Container(
  //           width: context.media.size.width - 40,
  //           height: 50,
  //           child: ClipRRect(
  //             borderRadius: BorderRadius.circular(8),
  //             child: RaisedButton(
  //               child: Text(
  //                 'GOT IT!',
  //                 style: context.theme.textTheme.button.copyWith(
  //                   color: Colors.white,
  //                 ),
  //               ),
  //               color: ColorExt.colorWithHex(0x098EF5),
  //               onPressed: () {
  //                 context.navigator.pushReplacementNamed(HomeScreen.routeName);
  //               },
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
