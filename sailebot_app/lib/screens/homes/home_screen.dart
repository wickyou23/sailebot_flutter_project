import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sailebot_app/screens/homes/preview_developing_screen.dart';
import 'package:sailebot_app/screens/menu/left_menu_screen.dart';
import 'package:sailebot_app/screens/notification/notification_screen.dart';
import 'package:sailebot_app/services/questionaire_service.dart';
import 'package:sailebot_app/utils/utils.dart';
import 'package:sailebot_app/widgets/banner_widget.dart';
import 'package:sailebot_app/widgets/home_navigation_bar.dart';
import 'package:sailebot_app/utils/extension.dart';

class _DumpObject {
  final String id;
  final String name;
  final String companyName;
  final String date;
  final DateTime dateTime;
  final bool isCountUp;

  _DumpObject(
    this.id, {
    this.name,
    this.companyName,
    this.date,
    this.isCountUp,
    this.dateTime,
  });
}

class HomeScreen extends StatefulWidget {
  static final routeName = '/HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final double _heighTab = 50;
  bool _isDeliveredSelected = true;
  // bool _isDeliveringHaveData = true;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<BannerWidgetState> _bannerKey = GlobalKey<BannerWidgetState>();

  List<_DumpObject> _dumpData = [
    _DumpObject(
      '1',
      name: 'PoC Name 1',
      companyName: 'Company Name 1',
      date: 'Date/Time delivery',
    ),
    _DumpObject(
      '2',
      name: 'Lars Ulrich',
      companyName: 'Metallica',
      date: '08:15:30 (counts up)',
      dateTime: DateTime.now(),
      isCountUp: true,
    ),
    _DumpObject(
      '3',
      name: 'Daves Mustaine',
      companyName: 'Megadeth',
      date: 'May 14, 2020 (1 day ago)',
    ),
    _DumpObject(
      '4',
      name: 'Mustaine',
      companyName: 'Daves Company',
      date: 'May 20, 2020 (4 days ago)',
    ),
    _DumpObject(
      '5',
      name: 'Ulrich',
      companyName: 'Lars Company',
      date: '08:15:30 (counts down)',
      dateTime: DateTime.now(),
      isCountUp: false,
    ),
    _DumpObject(
      '6',
      name: 'Peter',
      companyName: 'Game Company',
      date: 'Jun 20, 2020 (4 days ago)',
    ),
    _DumpObject(
      '7',
      name: 'John Wick',
      companyName: 'Assasin Company',
      date: 'Today',
    ),
  ];

  List<_DumpObject> _dumpDevelopingData = [
    _DumpObject(
      '11',
      name: '[Industry]',
      companyName: '[Digital Labor]',
      date: '[Date of First Digital Labor]',
    ),
    _DumpObject(
      '12',
      name: 'Technology',
      companyName: 'Digital Labor: 6',
      date: 'First Contact: May 14, 2020',
    ),
    _DumpObject(
      '13',
      name: 'Professional Services',
      companyName: 'Digital Labor: 10',
      date: 'First Contact: May 10, 2020',
    ),
    _DumpObject(
      '14',
      name: 'Construction',
      companyName: 'Digital Labor: 12',
      date: 'First Touch: May 05, 2020',
    ),
  ];

  @override
  void initState() {
    Utils.authAppStatusBar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _heightBg = 135 + context.media.viewPadding.top;
    Future.delayed(Duration(milliseconds: 500), () {
      _showBanner();
    });

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: Container(
        width: context.media.size.width * 0.77,
        child: Drawer(
          child: LeftMenuScreen(
            itemSelected: MenuEnum.home,
            goBackHandler: () {
              Future.delayed(Duration(milliseconds: 100), () {
                Utils.authAppStatusBar();
              });
            },
          ),
        ),
      ),
      body: BannerWidget(
        key: _bannerKey,
        title: 'Progress Saved',
        child: Stack(
          children: <Widget>[
            Container(
              height: _heightBg,
              decoration: BoxDecoration(
                color: Colors.white,
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
            ),
            HomeNaviBar(
              tintColor: Colors.white,
              title: 'Home',
              drawerPressed: () {
                _scaffoldKey.currentState.openDrawer();
              },
              notiPressed: () {
                context.navigator.pushNamed(NotificationScreen.routeName);
              },
            ),
            Container(
              padding: EdgeInsets.only(top: _heightBg - _heighTab + 1),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: <Widget>[
                    _tabWidget(
                      ValueKey('delivered_tab'),
                      'Delivered (${_dumpData.length})',
                      _isDeliveredSelected,
                      onPressed: () {
                        setState(() {
                          _isDeliveredSelected = true;
                        });
                      },
                    ),
                    _tabWidget(
                      ValueKey('delivering_tab'),
                      'Developing (${_dumpDevelopingData.length})',
                      !_isDeliveredSelected,
                      onPressed: () {
                        setState(() {
                          _isDeliveredSelected = false;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: _heightBg),
              child:
                  (_isDeliveredSelected) ? _deliverdPage() : _developingPage(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabWidget(Key key, String title, bool isSelected,
      {@required Function onPressed}) {
    return Container(
      key: key,
      height: _heighTab,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: isSelected ? Colors.white : Colors.transparent,
      ),
      width: (context.media.size.width - 50) / 2,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Text(
          title,
          style: context.theme.textTheme.headline6.copyWith(
            color: isSelected ? ColorExt.mainColor : Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }

  Widget _deliverdPage() {
    return _dumpData.isEmpty
        ? Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Actionable Opportunities coming soon!',
                style: context.theme.textTheme.headline6,
                textAlign: TextAlign.center,
              ),
            ),
          )
        : Container(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
              itemCount: _dumpData.length,
              itemBuilder: (_, idx) {
                _DumpObject _item = _dumpData[idx];
                return DeliveredCell(
                  ValueKey(_item.id),
                  _item,
                  onPressed: () {
                    context.navigator
                        .pushNamed(PreviewDevelopingScreen.routeName);
                  },
                );
              },
            ),
          );
  }

  Widget _developingPage() {
    return _dumpDevelopingData.isEmpty
        ? Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Actionable Opportunities coming soon!',
                style: context.theme.textTheme.headline6,
                textAlign: TextAlign.center,
              ),
            ),
          )
        : Container(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
              itemCount: _dumpDevelopingData.length,
              itemBuilder: (_, idx) {
                _DumpObject _item = _dumpDevelopingData[idx];
                return DeliveredCell(
                  ValueKey(_item.id),
                  _item,
                  isShowAct: false,
                  onPressed: null,
                );
              },
            ),
          );
  }

  void _showBanner() {
    if (!QuestionaireService().isShowBannerSaved) {
      return;
    }

    QuestionaireService().isShowBannerSaved = false;
    _bannerKey.currentState.showBanner(
      hideInDuration: Duration(seconds: 4),
    );
  }

  // Widget _deliveringPage() {
  //   const double _bgWidth = 260;
  //   return (_isDeliveringHaveData)
  //       ? Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //             Image.asset(
  //               'assets/images/bg_delivering.png',
  //               fit: BoxFit.cover,
  //               width: _bgWidth,
  //               height: _bgWidth * 0.6803278689,
  //             ),
  //             SizedBox(height: 30),
  //             Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 30),
  //               child: Text(
  //                 'Your Sailebot is working hard to develop 8 opportunities',
  //                 style: context.theme.textTheme.headline6,
  //                 textAlign: TextAlign.center,
  //               ),
  //             )
  //           ],
  //         )
  //       : Center(
  //           child: Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 30),
  //             child: Text(
  //               'Your Sailebot is working hard to generate Actionable Opportunities for you. Stay tuned!',
  //               style: context.theme.textTheme.headline6,
  //               textAlign: TextAlign.center,
  //             ),
  //           ),
  //         );
  // }

  // Widget _deliveredCell(Key key, _DumpObject item,
  //     {Function onPressed, bool isShowAct = true}) {
  //   return Container(
  //     padding: const EdgeInsets.only(bottom: 20),
  //     child: ClipRRect(
  //       borderRadius: BorderRadius.circular(10.0),
  //       child: FlatButton(
  //         padding: EdgeInsets.zero,
  //         child: Container(
  //           padding: const EdgeInsets.all(20),
  //           decoration: BoxDecoration(
  //             border: Border.all(
  //               color: Colors.grey,
  //               width: 0.5,
  //             ),
  //             borderRadius: BorderRadius.circular(10.0),
  //           ),
  //           child: Row(
  //             children: <Widget>[
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: <Widget>[
  //                   Text(
  //                     item.name,
  //                     style: context.theme.textTheme.headline6.copyWith(
  //                       fontWeight: FontWeight.w600,
  //                     ),
  //                   ),
  //                   SizedBox(height: 5),
  //                   Text(
  //                     item.companyName,
  //                     style: context.theme.textTheme.headline6.copyWith(
  //                       fontSize: 18,
  //                     ),
  //                   ),
  //                   SizedBox(height: 8),
  //                   Text(
  //                     item.date,
  //                     style: context.theme.textTheme.subtitle2.copyWith(
  //                       color: Colors.grey,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               Expanded(child: Container()),
  //               if (isShowAct)
  //                 Material(
  //                   color: ColorExt.colorWithHex(0xEBF8FF),
  //                   type: MaterialType.circle,
  //                   child: Container(
  //                     alignment: Alignment.center,
  //                     height: 50,
  //                     width: 50,
  //                     child: Text(
  //                       'Act',
  //                       style: context.theme.textTheme.headline6.copyWith(
  //                         color: ColorExt.mainColor,
  //                         fontWeight: FontWeight.w600,
  //                         fontSize: 17,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //             ],
  //           ),
  //         ),
  //         onPressed: onPressed,
  //       ),
  //     ),
  //   );
  // }
}

class DeliveredCell extends StatefulWidget {
  final Key key;
  final _DumpObject item;
  final Function onPressed;
  final bool isShowAct;

  DeliveredCell(
    this.key,
    this.item, {
    this.onPressed,
    this.isShowAct = true,
  });

  @override
  _DeliveredCellState createState() => _DeliveredCellState();
}

class _DeliveredCellState extends State<DeliveredCell> {
  Timer _timer;
  DateTime _dateTime;
  bool _isCount = false;

  @override
  void initState() {
    if (this.widget.item.isCountUp != null) {
      _isCount = true;
      _handleCount();
      _timer = Timer.periodic(Duration(seconds: 1), (_) {
        _handleCount();
        setState(() {});
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    debugPrint("DeliveredCell ${this.widget.key} dispose ============");
    super.dispose();
  }

  void _handleCount() {
    var crDate = this.widget.item.dateTime;
    var subSecond = ((DateTime.now().millisecondsSinceEpoch -
                crDate.millisecondsSinceEpoch) ~/
            1000)
        .toInt();
    if (this.widget.item.isCountUp == true) {
      _dateTime = crDate.add(Duration(seconds: subSecond));
    } else {
      _dateTime = crDate.subtract(Duration(seconds: subSecond));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 14),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: FlatButton(
          padding: EdgeInsets.zero,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      this.widget.item.name,
                      style: context.theme.textTheme.headline6.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ColorExt.myBlack,
                        fontSize: 16,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      this.widget.item.companyName,
                      style: context.theme.textTheme.headline5.copyWith(
                        fontSize: 14,
                        color: ColorExt.myBlack,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      (_isCount)
                          ? _dateTime.csToString('hh:mm:ss')
                          : this.widget.item.date,
                      style: context.theme.textTheme.subtitle2.copyWith(
                        fontSize: 11,
                        color: Colors.grey[800],
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
                Expanded(child: Container()),
                if (this.widget.isShowAct)
                  Material(
                    color: ColorExt.colorWithHex(0xEBF8FF),
                    type: MaterialType.circle,
                    child: Container(
                      alignment: Alignment.center,
                      height: 42,
                      width: 42,
                      child: Text(
                        'Act',
                        style: context.theme.textTheme.headline6.copyWith(
                          color: ColorExt.colorWithHex(0x098EF5),
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          onPressed: this.widget.onPressed,
        ),
      ),
    );
  }
}
