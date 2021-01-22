import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sailebot_app/screens/introduce/introduce_page.dart';
import 'package:sailebot_app/screens/users/update_profile_screen.dart';
import 'package:sailebot_app/utils/extension.dart';

class IntroduceScreen extends StatefulWidget {
  static final routeName = '/IntroduceScreen';

  @override
  _IntroduceScreenState createState() => _IntroduceScreenState();
}

class _IntroduceScreenState extends State<IntroduceScreen> {
  PageController _pageController;
  int _currentPageIdx = 0;
  bool _isShowSkip = false;

  @override
  void initState() {
    _pageController = PageController(initialPage: _currentPageIdx);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _pageController.addListener(() {
      int crPage = _pageController.page.round();
      if (_currentPageIdx != crPage) {
        setState(() {
          _currentPageIdx = crPage;
          if (_currentPageIdx == 2) {
            _isShowSkip = true;
          }
        });
      }
    });

    precacheImage(AssetImage("assets/images/intro_bg_1.png"), context);
    precacheImage(AssetImage("assets/images/intro_bg_2.png"), context);
    precacheImage(AssetImage("assets/images/intro_bg_3.png"), context);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            child: PageView(
              controller: _pageController,
              children: <Widget>[
                IntroducePage(
                  wDescription: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Build your Sailebot',
                        style: context.theme.textTheme.headline5.copyWith(
                          color: ColorExt.myBlack,
                          height: 1.3,
                        ),
                        children: [
                          WidgetSpan(
                            alignment: PlaceholderAlignment.top,
                            child: Text(
                              'TM',
                              style: context.theme.textTheme.headline5.copyWith(
                                fontSize: 11,
                              ),
                            ),
                          ),
                          TextSpan(
                            text:
                                ' to generate Actionable revenue Opportunities, hands-free.',
                            style: context.theme.textTheme.headline5.copyWith(
                              color: ColorExt.myBlack,
                              height: 1.3,
                              fontSize: 19,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  description:
                      'Build your Sailebot to generate Actionable revenue Opportunities, hands-free.',
                  image: AssetImage("assets/images/intro_bg_1.png"),
                  wtitle: RichText(
                    strutStyle: StrutStyle.fromTextStyle(
                      context.theme.appBarTheme.textTheme.headline6.copyWith(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    text: TextSpan(
                      text: 'Sailebot',
                      style: context.theme.appBarTheme.textTheme.headline6
                          .copyWith(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.top,
                          child: Text(
                            'TM',
                            style: context.theme.appBarTheme.textTheme.headline6
                                .copyWith(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IntroducePage(
                  description:
                      'Get notified when your approved prospects turn into Actionable Opportunities.',
                  image: AssetImage("assets/images/intro_bg_2.png"),
                  title: 'Actionable Opportunities',
                ),
                IntroducePage(
                  description:
                      'Swipe through leads to match with prospects, or add them to your Sailebot for targeting.',
                  image: AssetImage("assets/images/intro_bg_3.png"),
                  wtitle: RichText(
                    strutStyle: StrutStyle.fromTextStyle(
                      context.theme.appBarTheme.textTheme.headline6.copyWith(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    text: TextSpan(
                      text: 'Saileswipe',
                      style: context.theme.appBarTheme.textTheme.headline6
                          .copyWith(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.top,
                          child: Text(
                            'TM',
                            style: context.theme.appBarTheme.textTheme.headline6
                                .copyWith(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              Expanded(child: Container()),
              Container(
                alignment: Alignment.center,
                height: 50,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Material(
                          color: (_currentPageIdx == 0)
                              ? context.theme.primaryColor
                              : ColorExt.colorWithHex(0xB0C1DA),
                          type: MaterialType.circle,
                          child: Container(
                            height: 10,
                            width: 10,
                            child: null,
                          ),
                        ),
                        SizedBox(width: 10),
                        Material(
                          color: (_currentPageIdx == 1)
                              ? context.theme.primaryColor
                              : ColorExt.colorWithHex(0xB0C1DA),
                          type: MaterialType.circle,
                          child: Container(
                            height: 10,
                            width: 10,
                            child: null,
                          ),
                        ),
                        SizedBox(width: 10),
                        Material(
                          color: (_currentPageIdx == 2)
                              ? context.theme.primaryColor
                              : ColorExt.colorWithHex(0xB0C1DA),
                          type: MaterialType.circle,
                          child: Container(
                            height: 10,
                            width: 10,
                            child: null,
                          ),
                        ),
                      ],
                    ),
                    if (_isShowSkip)
                      Positioned(
                        right: 0,
                        width: 100,
                        height: 50,
                        child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: Text(
                            'Skip >>',
                            style: context.theme.textTheme.headline6.copyWith(
                              fontSize: 18,
                              color: context.theme.primaryColor,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          onPressed: () {
                            context.navigator
                                .pushReplacementNamed(UpdateProfileScreen.routeName);
                          },
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: context.media.viewPadding.bottom + 20,
              )
            ],
          ),
        ],
      ),
    );
  }
}
