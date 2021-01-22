import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sailebot_app/screens/auth/change_password_screen.dart';
import 'package:sailebot_app/screens/users/update_profile_screen.dart';
import 'package:sailebot_app/utils/extension.dart';
import 'package:sailebot_app/utils/utils.dart';
import 'package:sailebot_app/widgets/custom_navigation_bar.dart';

class ProfileDetailScreen extends StatefulWidget {
  static final routeName = '/ProfileDetailScreen';

  @override
  _ProfileDetailScreenState createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  @override
  void initState() {
    Utils.whiteStatusBar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _ratioTopImage = 0.65;
    final _heighTopImage = context.media.size.width * _ratioTopImage;
    final _topBgImage = -50.0;
    final _widthAvatar = 145.0;

    return Scaffold(
      body: Stack(
        children: [
          Stack(
            children: <Widget>[
              Positioned(
                top: _topBgImage,
                width: context.media.size.width,
                height: _heighTopImage,
                child: Image.asset(
                  'assets/images/bg_top_sailebot_swipe.png',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: ((_heighTopImage + _topBgImage) / 2) + 10,
                left: (context.media.size.width / 2) - (_widthAvatar / 2),
                child: Container(
                  height: _widthAvatar,
                  width: _widthAvatar,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(_widthAvatar / 2),
                    image: DecorationImage(
                      image: AssetImage('assets/images/bg_avatar_image.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Image.asset(
                    'assets/images/default_avatar.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: (_heighTopImage + _topBgImage) + (_widthAvatar / 2) + 10,
                width: context.media.size.width,
                child: Text(
                  'Justin Phung',
                  textAlign: TextAlign.center,
                  style: context.theme.textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                  ),
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(top: _heighTopImage + _topBgImage + 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ..._rowItem(context, title: 'Gender', value: 'Female'),
                    ..._rowItem(context,
                        title: 'Industry', value: 'Real Estate'),
                    ..._rowItem(context,
                        title: 'Offering', value: 'House For Rent'),
                    ..._rowItem(context,
                        title: 'Email address',
                        value: 'ranee.hhes@example.com'),
                    ..._rowItem(context,
                        title: 'Phone number', value: '1 (207) 776-1234'),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: Text(
                          'Change password',
                          textAlign: TextAlign.start,
                          style: context.theme.textTheme.headline6.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: ColorExt.mainColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onPressed: () {
                          context.navigator
                              .pushNamed(ChangePasswordScreen.routeName);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          CustomNavigationBar(
            navTitle: 'My Profile',
            rightBarIcon: ImageIcon(
              AssetImage('assets/images/ic_edit.png'),
              color: Colors.white,
              size: 30,
            ),
            rightBarOnPressed: () {
              context.navigator
                  .pushNamed(UpdateProfileScreen.routeName, arguments: true);
            },
          ),
        ],
      ),
    );
  }

  List<Widget> _rowItem(BuildContext context, {String title, String value}) {
    return [
      Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 10.0),
        child: Container(
          height: context.isSmallDevice ? 46 : 50,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Text(
                  title,
                  style: context.theme.textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  value,
                  style: context.theme.textTheme.headline5.copyWith(
                    fontSize: 14,
                    color: ColorExt.myBlack,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Divider(
        color: Colors.grey[350],
        height: 0.5,
        indent: 25,
        endIndent: 25,
      ),
    ];
  }
}
