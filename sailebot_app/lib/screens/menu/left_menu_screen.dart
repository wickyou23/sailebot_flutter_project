import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sailebot_app/screens/homes/home_screen.dart';
import 'package:sailebot_app/screens/sailebot/sailebot_setting_screen.dart';
import 'package:sailebot_app/screens/sailebot_setup/resume_questionaire_screen.dart';
import 'package:sailebot_app/screens/sailebot_setup/sailebot_setup_confirm_screen.dart';
import 'package:sailebot_app/screens/sailebot_swipe/sailebot_swipe_intro_screen.dart';
import 'package:sailebot_app/screens/sailebot_swipe/sailebot_swipe_screen.dart';
import 'package:sailebot_app/screens/settings/settings_screen.dart';
import 'package:sailebot_app/screens/support/support_screen.dart';
import 'package:sailebot_app/screens/users/proffile_detail_screen.dart';
import 'package:sailebot_app/services/local_store_service.dart';
import 'package:sailebot_app/services/questionaire_service.dart';
import 'package:sailebot_app/utils/constant.dart';
import 'package:sailebot_app/utils/extension.dart';

class LeftMenuScreen extends StatelessWidget {
  final Function goBackHandler;
  final MenuEnum itemSelected;
  final List<MenuEnum> settings = [
    MenuEnum.myProfile,
    MenuEnum.home,
    MenuEnum.sailebot,
    MenuEnum.saileSwipe,
    MenuEnum.setting,
    MenuEnum.support,
  ];

  LeftMenuScreen({this.itemSelected, this.goBackHandler});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/bg_left_menu.png',
          fit: BoxFit.cover,
        ),
        Padding(
          padding: EdgeInsets.only(
            top: context.media.viewPadding.top,
            bottom: context.media.viewPadding.bottom,
          ),
          child: Material(
            type: MaterialType.transparency,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: CupertinoButton(
                    padding: const EdgeInsets.only(
                      top: 16,
                      bottom: 16,
                      left: 0,
                      right: 10,
                    ),
                    minSize: 20,
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                  ),
                ),
                ..._buildItem(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildItem(BuildContext context) {
    bool isAddExpanded = false;
    final List<Widget> widgets = [];
    for (MenuEnum item in this.settings) {
      if (item == MenuEnum.myProfile) {
        widgets.add(
          ListTile(
            leading: Image.asset(
              'assets/images/default_avatar.png',
              fit: BoxFit.cover,
            ),
            title: Text(
              'User Name',
              style: context.theme.textTheme.headline6.copyWith(
                color: ColorExt.myBlack,
                fontWeight: FontWeight.bold,
                fontSize: 19,
              ),
            ),
            subtitle: Text(
              'SP-091291',
              style: context.theme.textTheme.subtitle1.copyWith(
                fontSize: 14,
              ),
            ),
            onTap: () {
              Scaffold.of(context).openEndDrawer();
              item.gotoScreen(context, this.goBackHandler);
            },
          ),
        );
        widgets.add(
          SizedBox(height: 10),
        );
      } else {
        if (item.isBottom && !isAddExpanded) {
          widgets.add(Expanded(child: Container()));
          isAddExpanded = true;
        }

        if (item.isHaveLine) {
          widgets.add(
            Divider(
              height: 0.5,
              color: Colors.grey[350],
              indent: 20,
            ),
          );
        }

        widgets.add(
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            leading: (item == this.itemSelected)
                ? item.highLighIcon
                : item.normalIcon,
            title: Text(
              item.title,
              style: (item == this.itemSelected)
                  ? context.theme.textTheme.headline5.copyWith(
                      color: Constaint.mainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    )
                  : context.theme.textTheme.headline5.copyWith(
                      color: Colors.grey[800],
                      fontSize: 19,
                    ),
            ),
            onTap: () {
              Scaffold.of(context).openEndDrawer();
              item.gotoScreen(context, this.goBackHandler);
            },
          ),
        );
      }
    }

    return widgets;
  }
}

enum MenuEnum { myProfile, home, sailebot, saileSwipe, setting, support }

extension MenuEnumExt on MenuEnum {
  double get _iconSize {
    return 30;
  }

  String get title {
    switch (this) {
      case MenuEnum.myProfile:
        return '';
      case MenuEnum.home:
        return 'Home';
      case MenuEnum.sailebot:
        return 'Sailebot';
      case MenuEnum.saileSwipe:
        return 'Saileswipe';
      case MenuEnum.setting:
        return 'Settings';
      case MenuEnum.support:
        return 'Contact Support';
      default:
        return '';
    }
  }

  ImageIcon get normalIcon {
    switch (this) {
      case MenuEnum.myProfile:
        return null;
      case MenuEnum.home:
        return ImageIcon(
          AssetImage('assets/images/ic_menu_home.png'),
          size: _iconSize,
        );
      case MenuEnum.sailebot:
        return ImageIcon(
          AssetImage('assets/images/ic_menu_logo_sailebot.png'),
          size: _iconSize,
        );
      case MenuEnum.saileSwipe:
        return ImageIcon(
          AssetImage('assets/images/ic_menu_sailebot_swipe.png'),
          size: _iconSize,
        );
      case MenuEnum.setting:
        return ImageIcon(
          AssetImage('assets/images/ic_menu_settings.png'),
          size: _iconSize,
        );
      case MenuEnum.support:
        return ImageIcon(
          AssetImage('assets/images/ic_menu_support.png'),
          size: _iconSize,
        );
      default:
        return null;
    }
  }

  ImageIcon get highLighIcon {
    switch (this) {
      case MenuEnum.myProfile:
        return null;
      case MenuEnum.home:
        return ImageIcon(
          AssetImage('assets/images/ic_menu_home.png'),
          color: Constaint.mainColor,
          size: _iconSize,
        );
      case MenuEnum.sailebot:
        return ImageIcon(
          AssetImage('assets/images/ic_menu_logo_sailebot.png'),
          color: Constaint.mainColor,
          size: _iconSize,
        );
      case MenuEnum.saileSwipe:
        return ImageIcon(
          AssetImage('assets/images/ic_menu_sailebot_swipe.png'),
          color: Constaint.mainColor,
          size: _iconSize,
        );
      case MenuEnum.setting:
        return ImageIcon(
          AssetImage('assets/images/ic_menu_settings.png'),
          color: Constaint.mainColor,
          size: _iconSize,
        );
      case MenuEnum.support:
        return ImageIcon(
          AssetImage('assets/images/ic_menu_support.png'),
          color: Constaint.mainColor,
          size: _iconSize,
        );
      default:
        return null;
    }
  }

  bool get isBottom {
    return this == MenuEnum.support || this == MenuEnum.setting;
  }

  bool get isHaveLine {
    return this == MenuEnum.sailebot ||
        this == MenuEnum.saileSwipe ||
        this == MenuEnum.support;
  }

  void gotoScreen(BuildContext context, Function goBackHandler) {
    switch (this) {
      case MenuEnum.myProfile:
        context.navigator
            .pushNamed(ProfileDetailScreen.routeName)
            .then((value) {
          goBackHandler();
        });

        break;
      case MenuEnum.home:
        context.navigator.pushReplacementNamed(HomeScreen.routeName);
        break;
      case MenuEnum.sailebot:
        if (LocalStoreService().isSetupSailebot) {
          context.navigator
              .pushNamed(SaileBotSettingScreen.routeName)
              .then((value) {
            goBackHandler();
          });
        } else {
          if (QuestionaireService().isPendingProgress) {
            context.navigator
                .pushNamed(ResumeQuestionaireScreen.routeName)
                .then((value) {
              goBackHandler();
            });
          } else {
            context.navigator.pushNamed(
              SaileBotSetupConfirmScreen.routeName,
              arguments: {
                'shouldShowBuildSailebotFirst': true,
                'isPush': true,
              },
            ).then((value) {
              goBackHandler();
            });
          }
        }

        break;
      case MenuEnum.saileSwipe:
        if (LocalStoreService().swipeNumberStack <= 10) {
          context.navigator.pushNamed(
            SaileBotSwipeIntroScreen.routeName,
            arguments: goBackHandler,
          );
        } else {
          context.navigator.pushNamed(
            SaileBotSwipeScreen.routeName,
            arguments: goBackHandler,
          );
        }

        break;
      case MenuEnum.setting:
        context.navigator.pushNamed(SettingScreen.routeName).then((value) {
          goBackHandler();
        });

        break;
      case MenuEnum.support:
        context.navigator.pushNamed(SupportScreen.routeName).then((value) {
          goBackHandler();
        });

        break;
      default:
        break;
    }
  }
}
