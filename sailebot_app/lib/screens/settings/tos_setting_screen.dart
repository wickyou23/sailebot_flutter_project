import 'package:flutter/material.dart';
import 'package:sailebot_app/widgets/custom_navigation_bar.dart';
import 'package:sailebot_app/utils/extension.dart';

class TOSSettingScreen extends StatelessWidget {
  static final routeName = '/TOSSettingScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomNavigationBar(
            navTitle: 'Term of Service',
            bgImage: 'assets/images/bg_default_navigation_bar.png',
          ),
          Container(
            padding: EdgeInsets.only(
              top: context.media.viewPadding.top +
                  CustomNavigationBar.heightNavBar,
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 40,
              ),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris odio integer consectetur odio. Elementum velit eget pellentesque pretium placerat sit morbi sapien. Velit sed maecenas nisl lorem volutpat eget mi. Est nulla nisl scelerisque rhoncus.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris odio integer consectetur odio. Elementum velit eget pellentesque pretium placerat sit morbi sapien. Velit sed maecenas nisl lorem volutpat eget mi. Est nulla nisl scelerisque rhoncus.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris odio integer consectetur odio. Elementum velit eget pellentesque pretium placerat sit morbi sapien. Velit sed maecenas nisl lorem volutpat eget mi. Est nulla nisl scelerisque rhoncus.',
                style: context.theme.textTheme.headline5.copyWith(
                    fontSize: 14, height: 1.5, color: Colors.grey[900]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
