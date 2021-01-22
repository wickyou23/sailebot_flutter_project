import 'package:flutter/material.dart';
import 'package:sailebot_app/widgets/common_intro_widget.dart';
import 'package:sailebot_app/widgets/custom_navigation_bar.dart';
import 'package:sailebot_app/utils/extension.dart';

class SaileBotReqCampaignScreen extends StatefulWidget {
  static final routeName = '/SaileBotReqCampaignScreen';

  @override
  _SaileBotReqCampaignScreenState createState() =>
      _SaileBotReqCampaignScreenState();
}

class _SaileBotReqCampaignScreenState extends State<SaileBotReqCampaignScreen> {
  final double _heightImage = 216;
  bool _isComfirmScreen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomNavigationBar(
            navTitle: '',
            tintColor: Colors.black,
          ),
          Container(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 250),
              child: (!_isComfirmScreen)
                  ? CommonIntroWidget(
                      key: ValueKey('_request_campaign'),
                      assetImage: 'assets/images/bg_request_campaign.png',
                      widthImage: _heightImage,
                      ratioImage: 0.6803278689,
                      description:
                          'Would you like to schedule a campaign review to update your Sailebot?',
                      titleButton: 'Yes, Notify Saile Support',
                      onPressed: () {
                        _isComfirmScreen = true;
                        setState(() {});
                      },
                    )
                  : CommonIntroWidget(
                      key: ValueKey('_comfirm_campaign'),
                      assetImage: 'assets/images/bg_comfirm_campaign.png',
                      widthImage: _heightImage,
                      ratioImage: 0.6803278689,
                      description:
                          'Saile Support has received your request to update your Sailebot. We will reach out to you soon to discuss the detail of the update.',
                      titleButton: 'Got it!',
                      onPressed: () {
                        context.navigator.pop();
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
