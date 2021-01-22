import 'package:flutter/material.dart';
import 'package:sailebot_app/frameworks/flutter_tag/item_tags.dart';
import 'package:sailebot_app/frameworks/flutter_tag/tags.dart';
import 'package:sailebot_app/utils/extension.dart';
import 'package:sailebot_app/utils/utils.dart';
import 'package:sailebot_app/widgets/custom_navigation_bar.dart';

class SaileBotSettingScreen extends StatefulWidget {
  static final routeName = '/SaileBotSettingScreen';

  @override
  _SaileBotSettingScreenState createState() => _SaileBotSettingScreenState();
}

class _SaileBotSettingScreenState extends State<SaileBotSettingScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    Utils.whiteStatusBar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Container(
                        color: Colors.white,
                        child: Container(
                          padding: const EdgeInsets.only(
                            top: 10,
                            bottom: 25,
                            right: 25,
                            left: 25,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                ColorExt.colorWithHex(0x098EF5),
                                ColorExt.colorWithHex(0x12B3FF)
                                    .withPercentAlpha(0.60),
                              ],
                            ),
                          ),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Sailebot Summary',
                                  style: context.theme.textTheme.headline6
                                      .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Reprehenderit pariatur quis occaecat pariatur reprehenderit tempor. Enim dolor cillum non ut reprehenderit. Proident labore eu nulla eiusmod proident laboris eu.',
                                  style: context.theme.textTheme.subtitle1
                                      .copyWith(
                                    color: Colors.white,
                                    height: 1.5,
                                    fontSize: 14,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 20,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Sailebot Setting',
                          style: context.theme.textTheme.headline6.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                          ),
                        ),
                      ),
                      ..._buildRowItem('Sailebot ID', desc: 'SB33101'),
                      ..._buildRowItem('AO Delivery',
                          desc: 'renee.hughes@example.com'),
                      ..._buildRowItem('Elasticity', desc: '10'),
                      ..._buildRowItem(
                        'Target Titles',
                        child: Padding(
                          padding: const EdgeInsets.only(top: 9, bottom: 14),
                          child: _buildTags(
                            [
                              'Chief Revenue Officer',
                              'Marketing Manager',
                              'Director of Sales',
                            ],
                          ),
                        ),
                      ),
                      ..._buildRowItem(
                        'Keywords',
                        child: Padding(
                          padding: const EdgeInsets.only(top: 9, bottom: 14),
                          child: _buildTags(
                            [
                              'Revenue',
                              'Sales',
                              'Lead-gen',
                              'Lead-gen',
                              'Demand-gen',
                            ],
                          ),
                        ),
                      ),
                      ..._buildRowItem(
                        'Industries',
                        child: Padding(
                          padding: const EdgeInsets.only(top: 9, bottom: 14),
                          child: _buildTags(
                            [
                              'Consulting',
                              'Media',
                              'Software',
                            ],
                          ),
                        ),
                      ),
                      // Expanded(child: Container()),
                      SizedBox(height: 16),
                      // Container(
                      //   height: 50,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(8),
                      //     border:
                      //         Border.all(color: ColorExt.mainColor, width: 1),
                      //   ),
                      //   child: FlatButton(
                      //     onPressed: () {
                      //       // context.navigator.pushNamed(
                      //       //     SaileBotReqCampaignScreen.routeName);
                      //     },
                      //     child: Text(
                      //       'REQUEST REVIEW',
                      //       style: context.theme.textTheme.headline6.copyWith(
                      //         color: ColorExt.mainColor,
                      //         fontSize: 15,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: context.media.viewPadding.bottom == 0
                            ? 20
                            : context.media.viewPadding.bottom,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          CustomNavigationBar(
            tintColor: Colors.white,
            navTitle: 'Sailebot Setting',
          ),
        ],
      ),
    );
  }

  Widget _buildTags(List<String> items) {
    return Tags(
      itemCount: items.length,
      alignment: WrapAlignment.start,
      runSpacing: 8,
      itemBuilder: (int index) {
        final item = items[index];
        return ItemTags(
          index: index,
          title: item,
          active: false,
          pressEnabled: false,
          elevation: 0,
          border: Border.fromBorderSide(BorderSide.none),
          color: ColorExt.colorWithHex(0xEBF8FF),
          textColor: ColorExt.mainColor,
          textStyle: context.theme.textTheme.subtitle2.copyWith(
            fontSize: 14,
          ),
        );
      },
    );
  }

  List<Widget> _buildRowItem(String title, {Widget child, String desc}) {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Text(
                  title,
                  style: context.theme.textTheme.subtitle1.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: (desc == null)
                  ? child
                  : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Text(
                        desc,
                        style: context.theme.textTheme.subtitle1.copyWith(
                          fontSize: 14,
                        ),
                      ),
                  ),
            ),
          ],
        ),
      ),
      Divider(
        color: Colors.grey[350],
        height: 0.5,
        indent: 20,
        endIndent: 20,
      )
    ];
  }
}
