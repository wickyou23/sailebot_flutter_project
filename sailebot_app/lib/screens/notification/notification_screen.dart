import 'package:flutter/material.dart';
import 'package:sailebot_app/enum/notification_enum.dart';
import 'package:sailebot_app/models/notification_object.dart';
import 'package:sailebot_app/screens/notification/notification_detail_screen.dart';
import 'package:sailebot_app/utils/extension.dart';
import 'package:sailebot_app/utils/utils.dart';
import 'package:sailebot_app/widgets/custom_navigation_bar.dart';
import 'package:sailebot_app/widgets/section_listview_widget.dart';

class NotificationScreen extends StatefulWidget {
  static final routeName = '/NotificationScreen';

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<NotiObject> _notis = [
    NotiObject(
      message: 'Your Sailebot has been updated!',
      date: 'about an hour ago',
      type: NotificationEnum.updateSailebot,
    ),
    NotiObject(
      message: 'Your mobile Sailebot has been launched/activated',
      date: '7 hours ago',
      type: NotificationEnum.sailebotLaunched,
      isRead: true,
    ),
    NotiObject(
      message: 'Your Sailebot has been created!',
      date: 'a day ago',
      type: NotificationEnum.createdSailebot,
      isRead: true,
    ),
    NotiObject(
      message:
          'You\'ve swiped right 3 times. Create a Sailebot to act upon these opportunies.',
      date: '3 days ago',
      type: NotificationEnum.reminderCreateSailebot,
      isRead: true,
    ),
    NotiObject(
      message: 'Welcome to Saile, Roe Pema!',
      date: 'a week ago',
      type: NotificationEnum.wellcome,
      isRead: true,
    ),
  ];

  final Map<String, List<NotiObject>> _usedItem = {};
  void _filterNoti() {
    for (var item in _notis) {
      if (item.isRead) {
        _usedItem.update('read', (value) {
          value.add(item);
          return value;
        }, ifAbsent: () {
          return [item];
        });
      } else {
        _usedItem.update('new', (value) {
          value.add(item);
          return value;
        }, ifAbsent: () {
          return [item];
        });
      }
    }
  }

  @override
  void initState() {
    _filterNoti();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomNavigationBar(
            navTitle: 'Notifications',
            backgroundColor: ColorExt.colorWithHex(0x098EF5),
          ),
          Container(
            padding: EdgeInsets.only(
              top: context.media.viewPadding.top +
                  CustomNavigationBar.heightNavBar,
            ),
            child: SectionListView(
              numberOfSection: () {
                return _usedItem.length;
              },
              numberOfRowsInSection: (section) {
                if (section == 0) {
                  return _usedItem['new'].length;
                } else {
                  return _usedItem['read'].length;
                }
              },
              sectionWidget: (section) {
                return Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    (section == 0) ? 'New' : 'Read',
                    style: context.theme.textTheme.headline6.copyWith(
                      fontSize: 18,
                    ),
                  ),
                );
              },
              rowWidget: (section, row) {
                NotiObject _item;
                if (section == 0) {
                  _item = _usedItem['new'][row];
                } else {
                  _item = _usedItem['read'][row];
                }

                return Column(
                  children: <Widget>[
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 16),
                      leading: Material(
                        type: MaterialType.circle,
                        color: _item.isRead
                            ? Colors.grey[400]
                            : ColorExt.colorWithHex(0xEBF8FF),
                        child: Container(
                          width: 60,
                          height: 60,
                          padding: const EdgeInsets.all(12),
                          child: ImageIcon(
                            AssetImage('assets/images/ic_bell.png'),
                            color: _item.isRead
                                ? Colors.grey[800]
                                : ColorExt.colorWithHex(0x098EF5),
                          ),
                        ),
                      ),
                      title: Text(
                        _item.message,
                        style: context.theme.textTheme.headline6,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Text(
                          _item.date,
                          style: context.theme.textTheme.subtitle2.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      onTap: () {
                        context.navigator
                            .pushNamed(
                          NotificationDetailScreen.routeName,
                          arguments: _item,
                        )
                            .then((value) {
                          Future.delayed(Duration(milliseconds: 200), () {
                            Utils.authAppStatusBar();
                          });
                        });
                      },
                    ),
                    Divider(
                      color: Colors.grey[350],
                      height: 0.5,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
