import 'package:flutter/material.dart';
// import 'package:sailebot_app/data/repository/auth_repository.dart';
import 'package:sailebot_app/screens/auth/authentication_screen.dart';
import 'package:sailebot_app/screens/homes/home_screen.dart';
import 'package:sailebot_app/screens/users/update_profile_screen.dart';
import 'package:sailebot_app/services/local_store_service.dart';
import 'package:sailebot_app/utils/extension.dart';

class SplashScreen extends StatelessWidget {
  static final routeName = '/';

  Future<void> _handleLogicLaunchingApp(BuildContext context) async {
    // var user = await AuthRepository().getCurrentUser();
    // if (user != null) {
    // } else {
    //   Future.delayed(Duration(seconds: 2), () {
    //     context.navigator.pushReplacementNamed(AuthenticationScreen.routeName);
    //   });
    // }

    bool isSignIn = LocalStoreService().isSignIn;
    bool isSaveProfile = LocalStoreService().isSaveProfile;

    Future.delayed(Duration(seconds: 2), () {
      if (isSignIn) {
        if (isSaveProfile) {
          context.navigator.pushReplacementNamed(HomeScreen.routeName);
        } else {
          context.navigator.pushReplacementNamed(UpdateProfileScreen.routeName);
        }
      } else {
        context.navigator.pushReplacementNamed(AuthenticationScreen.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _handleLogicLaunchingApp(context);

    return Container(
      child: Image.asset(
        'assets/images/saile_splash_screen.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
