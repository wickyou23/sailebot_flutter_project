import 'package:flutter/material.dart';
import 'package:sailebot_app/screens/auth/authentication_screen.dart';
import 'package:sailebot_app/screens/menu/left_menu_screen.dart';
import 'package:sailebot_app/screens/settings/policy_setting_screen.dart';
import 'package:sailebot_app/screens/settings/tos_setting_screen.dart';
import 'package:sailebot_app/utils/utils.dart';
import 'package:sailebot_app/widgets/custom_navigation_bar.dart';
import 'package:sailebot_app/widgets/home_navigation_bar.dart';
import 'package:sailebot_app/utils/extension.dart';
import 'package:sailebot_app/wireframe.dart';

class SettingScreen extends StatefulWidget {
  static final routeName = '/SettingScreen';

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<SettingEnum> _settings = [
    SettingEnum.termOfService,
    SettingEnum.privacy,
    SettingEnum.signout,
  ];

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
            tintColor: Colors.white,
            backgroundColor: ColorExt.colorWithHex(0x098EF5),
            navTitle: 'Settings',
          ),
          Container(
            padding: EdgeInsets.only(
              top: context.media.viewPadding.top + HomeNaviBar.heightNavBar,
            ),
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemBuilder: (_, idx) {
                if (idx == _settings.length) {
                  return Divider(
                    color: Colors.grey[350],
                    height: 0.5,
                    indent: 16,
                    endIndent: 16,
                  );
                }

                var _item = _settings[idx];
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 8,
                  ),
                  title: Text(
                    _item.title,
                    style: context.theme.textTheme.headline5.copyWith(
                      color: ColorExt.myBlack,
                      fontSize: 19,
                    ),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    _item.gotoScreen(context);
                  },
                );
              },
              separatorBuilder: (_, idx) {
                if (idx == _settings.length - 1) {
                  return Container();
                }

                return Divider(
                  color: Colors.grey[350],
                  height: 0.5,
                  indent: 16,
                  endIndent: 16,
                );
              },
              itemCount: _settings.length + 1,
            ),
          ),
        ],
      ),
    );
  }
}

enum SettingEnum { termOfService, privacy, signout }

extension SettingEnumExt on SettingEnum {
  String get title {
    switch (this) {
      case SettingEnum.termOfService:
        return 'Term of Service';
      case SettingEnum.privacy:
        return 'Privacy Policy';
      case SettingEnum.signout:
        return 'Log Out';
      default:
        return '';
    }
  }

  void gotoScreen(BuildContext context) {
    switch (this) {
      case SettingEnum.termOfService:
        context.navigator.pushNamed(TOSSettingScreen.routeName);
        break;
      case SettingEnum.privacy:
        context.navigator.pushNamed(PolicySettingScreen.routeName);
        break;
      case SettingEnum.signout:
        AppWireFrame.logout();
        context.navigator.pushNamedAndRemoveUntil(
          AuthenticationScreen.routeName,
          (route) => false,
          arguments: {'shouldShowSignupFirst': false},
        );
        break;
      default:
        break;
    }
  }
}
