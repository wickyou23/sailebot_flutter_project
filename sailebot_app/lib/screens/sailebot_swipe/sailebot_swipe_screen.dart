import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sailebot_app/frameworks/swipe_stack/swipe_stack.dart';
import 'package:sailebot_app/screens/homes/home_screen.dart';
import 'package:sailebot_app/screens/menu/left_menu_screen.dart';
import 'package:sailebot_app/screens/sailebot_swipe/sailebot_swipe_build_screen.dart';
import 'package:sailebot_app/services/local_store_service.dart';
import 'package:sailebot_app/utils/extension.dart';
import 'package:sailebot_app/utils/utils.dart';
import 'package:sailebot_app/widgets/banner_widget.dart';
import 'package:sailebot_app/widgets/common_intro_widget.dart';
import 'package:sailebot_app/widgets/custom_navigation_bar.dart';

class SaileBotSwipeScreen extends StatefulWidget {
  static final routeName = '/SaileBotSwipeScreen';

  @override
  _SaileBotSwipeScreenState createState() => _SaileBotSwipeScreenState();
}

class _SaileBotSwipeScreenState extends State<SaileBotSwipeScreen>
    with SingleTickerProviderStateMixin {
  final _maxStackInADay = 10;
  final _ratioTopImage = 0.65;

  var _maxImage = 150.0;
  int _numberSwipeRight = 0;
  int _numberStack = 1;
  DateTime _swipeDate;
  bool _isResetStack = true;
  bool _isFirstSwipeRightThreeTime = false;

  List<int> _dumpData = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  bool _onSwipe = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<BannerWidgetState> _bannerKey = GlobalKey<BannerWidgetState>();
  GlobalKey<SwipeStackState> _swipeKey = GlobalKey<SwipeStackState>();

  @override
  void initState() {
    Utils.whiteStatusBar();
    _setupTheFirstTime();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint('${SaileBotSwipeScreen.routeName} dispose ===========');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _setupTheFirstTime() {
    var _swipeTimestamp = LocalStoreService().swipeDate;
    if (_swipeTimestamp != null) {
      _swipeDate = DateTime.fromMillisecondsSinceEpoch(_swipeTimestamp);
      _isResetStack = !_swipeDate.isToday();
      _numberSwipeRight = LocalStoreService().swipeNumberSwipeRight;
      if (!_isResetStack) {
        _numberStack = LocalStoreService().swipeNumberStack;
        _isFirstSwipeRightThreeTime =
            LocalStoreService().swipeIsFirstSwipeRightThreeTime;
        _dumpData = [];
        if (_numberStack <= _maxStackInADay) {
          _dumpData =
              List.generate(_maxStackInADay - _numberStack + 1, (idx) => idx);
        }
      } else {
        _swipeDate = DateTime.now();
        LocalStoreService().swipeDate = _swipeDate.millisecondsSinceEpoch;
        LocalStoreService().swipeNumberStack = null;
        LocalStoreService().swipeNumberSwipeRight = null;
      }
    } else {
      _swipeDate = DateTime.now();
      LocalStoreService().swipeDate = _swipeDate.millisecondsSinceEpoch;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final _heighTopImage = context.media.size.width * _ratioTopImage;
    _maxImage = (context.isSmallDevice) ? 150 : 180;

    return Scaffold(
      key: _scaffoldKey,
      drawer: Container(
        width: context.media.size.width * 0.77,
        child: Drawer(
          child: LeftMenuScreen(
            itemSelected: MenuEnum.saileSwipe,
          ),
        ),
      ),
      body: BannerWidget(
        key: _bannerKey,
        title: 'Added to Saile Campaign',
        child: Stack(
          children: [
            if (_numberStack < _maxStackInADay + 1)
              OverflowBox(
                alignment: AlignmentDirectional.topCenter,
                maxHeight: context.media.size.height,
                minWidth: context.media.size.width,
                child: Opacity(
                  opacity: 0.5,
                  child: Image(
                    image: AssetImage('assets/images/bg_screen.png'),
                    fit: BoxFit.cover,
                    width: context.media.size.width,
                    height: context.media.size.height,
                  ),
                ),
              ),
            _buildSwipe(),
            if (_numberStack < _maxStackInADay + 1)
              CustomNavigationBar(
                tintColor: Colors.white,
                navTitle: '$_numberStack/$_maxStackInADay',
              ),
            if (!_onSwipe && _numberStack < _maxStackInADay + 1)
              Positioned(
                top: _heighTopImage - 20,
                left: 10,
                child: CupertinoButton(
                  child: Image.asset(
                    'assets/images/ic_double_arrow_left.png',
                    fit: BoxFit.cover,
                    width: 30,
                    height: 30,
                  ),
                  onPressed: () {
                    _swipeKey.currentState.swipeLeft();
                  },
                ),
              ),
            if (!_onSwipe && _numberStack < _maxStackInADay + 1)
              Positioned(
                top: _heighTopImage - 20,
                right: 10,
                child: CupertinoButton(
                  child: Image.asset(
                    'assets/images/ic_double_arrow_right.png',
                    fit: BoxFit.cover,
                    width: 30,
                    height: 30,
                  ),
                  onPressed: () {
                    _swipeKey.currentState.swipeRight();
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem() {
    final _heighTopImage = context.media.size.width * _ratioTopImage;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 15.0),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            width: context.media.size.width,
            height: _heighTopImage,
            child: Image.asset(
              'assets/images/bg_top_sailebot_swipe.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: _heighTopImage / 2 + 16,
            left: (context.media.size.width / 2) - (_maxImage / 2),
            child: Container(
              height: _maxImage,
              width: _maxImage,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(_maxImage / 2),
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
            top: _heighTopImage +
                (_maxImage / 2) -
                ((context.isSmallDevice) ? 20 : 0),
            width: context.media.size.width,
            height:
                context.media.size.height - (_heighTopImage + (_maxImage / 2)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: ImageIcon(
                      AssetImage('assets/images/ic_credit_card.png'),
                      size: 30,
                      color: ColorExt.colorWithHex(0x098EF5),
                    ),
                    title: Text(
                      'Technology',
                      style: context.theme.textTheme.headline5.copyWith(
                        fontSize: 19.0,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: ImageIcon(
                      AssetImage('assets/images/ic_users.png'),
                      size: 30,
                      color: ColorExt.colorWithHex(0x098EF5),
                    ),
                    title: Text(
                      '7 employees',
                      style: context.theme.textTheme.headline5.copyWith(
                        fontSize: 19.0,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: ImageIcon(
                      AssetImage('assets/images/ic_dollar_sign.png'),
                      size: 30,
                      color: ColorExt.colorWithHex(0x098EF5),
                    ),
                    title: Text(
                      '1,000,000',
                      style: context.theme.textTheme.headline5.copyWith(
                        fontSize: 19.0,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: ImageIcon(
                      AssetImage('assets/images/ic_tag.png'),
                      size: 30,
                      color: ColorExt.colorWithHex(0x098EF5),
                    ),
                    title: Text(
                      'Product manager',
                      style: context.theme.textTheme.headline5.copyWith(
                        fontSize: 19.0,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: ImageIcon(
                      AssetImage('assets/images/ic_shopping_cart.png'),
                      size: 30,
                      color: ColorExt.colorWithHex(0x098EF5),
                    ),
                    title: Text(
                      '[Product/Service] Procuring',
                      style: context.theme.textTheme.headline5.copyWith(
                        fontSize: 19.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwipe() {
    if (_numberStack == _maxStackInADay + 1) {
      Utils.blackStatusBar();
      return CommonIntroWidget(
        assetImage: "assets/images/bg_top_swipe_limit.png",
        widthImage: 260,
        ratioImage: 0.680327869,
        description:
            "Way to go! You used all 10 Saileswipes today. Come back tomorrow for 10 new contact recommendations.",
        titleButton: "Go to Dashboard".toUpperCase(),
        onPressed: () {
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

          Future.delayed(Duration(milliseconds: 100), () {
            Utils.whiteStatusBar();
          });
        },
      );
    } else {
      return SwipeStack(
        key: _swipeKey,
        children: _dumpData.map(
          (int index) {
            return SwiperItem(
              builder: (SwiperPosition position, double progress) {
                return _buildItem();
              },
            );
          },
        ).toList(),
        visibleCount: 3,
        stackFrom: StackFrom.None,
        translationInterval: 6,
        scaleInterval: 0.03,
        padding: EdgeInsets.zero,
        onEnd: () {
          debugPrint("onEnd");
        },
        onDrag: () {
          debugPrint("onDrag");
          _bannerKey.currentState.forceHide();
          if (!_onSwipe) {
            setState(() {
              _onSwipe = true;
            });
          }
        },
        onEndDrag: () {
          debugPrint("onEndDrag");
          if (_onSwipe) {
            setState(() {
              _onSwipe = false;
            });
          }
        },
        onSwipe: (int index, SwiperPosition position) {
          if (_bannerKey.currentState.isShowing) {
            _bannerKey.currentState.forceHide();
          }

          if (position == SwiperPosition.Right) {
            _numberSwipeRight += 1;
            LocalStoreService().swipeNumberSwipeRight = _numberSwipeRight;
            _bannerKey.currentState.showBanner(
              hideInDuration: Duration(seconds: 2),
            );
          }

          _numberStack += 1;
          LocalStoreService().swipeNumberStack = _numberStack;
          _dumpData.removeLast();
          setState(() {});
          if (_isFirstSwipeRightThreeTime ||
              LocalStoreService().isSetupSailebot) {
            return;
          }
          if (_numberSwipeRight == 3) {
            _numberSwipeRight = 0;
            LocalStoreService().swipeNumberSwipeRight = _numberSwipeRight;
            _isFirstSwipeRightThreeTime = true;
            LocalStoreService().swipeIsFirstSwipeRightThreeTime =
                _isFirstSwipeRightThreeTime;
            _bannerKey.currentState.forceHide();
            context.navigator
                .pushNamed(SaileBotSwipeBuildScreen.routeName)
                .then(
              (value) {
                Utils.whiteStatusBar();
              },
            );
          }
        },
        onRewind: (int index, SwiperPosition position) {
          debugPrint("onRewind $index $position");
        },
      );
    }
  }
}
