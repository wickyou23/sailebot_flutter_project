import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sailebot_app/bloc/auth/auth_bloc.dart';
import 'package:sailebot_app/services/local_store_service.dart';
import 'package:sailebot_app/services/navigation_service.dart';
import 'package:sailebot_app/utils/utils.dart';
import 'package:sailebot_app/wireframe.dart';
import 'bloc/simple_bloc_delegate.dart';
import 'package:bloc/bloc.dart';
import 'package:sailebot_app/utils/extension.dart';

Future<Null> main() async {
  // Lock Orientation
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);

  WidgetsFlutterBinding.ensureInitialized();
  Utils.authAppStatusBar();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  await LocalStoreService().config();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage('assets/images/bg_screen.png'), context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(),
        )
      ],
      child: MaterialApp(
        navigatorKey: NavigationService().navigatorKey,
        theme: ThemeData(
          primaryColor: ColorExt.colorWithHex(0x12B3FF),
          primarySwatch: Colors.blue,
          highlightColor: ColorExt.colorWithHex(0x12B3FF).withPercentAlpha(0.2),
          splashColor: ColorExt.colorWithHex(0x12B3FF).withPercentAlpha(0.3),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline3: TextStyle(
                    fontFamily: 'FlayfairDisplay',
                    fontWeight: FontWeight.normal,
                    fontSize: 48,
                  ),
                  headline4: TextStyle(
                    fontFamily: 'FlayfairDisplay',
                    fontWeight: FontWeight.normal,
                    fontSize: 34,
                  ),
                  headline5: TextStyle(
                    fontFamily: 'FlayfairDisplay',
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                  ),
                  headline6: TextStyle(
                    fontFamily: 'FlayfairDisplay',
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                  subtitle1: TextStyle(
                    fontFamily: 'FlayfairDisplay',
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                  subtitle2: TextStyle(
                    fontFamily: 'FlayfairDisplay',
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                  button: TextStyle(
                    fontFamily: 'FlayfairDisplay',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
          ),
          textTheme: Platform.isIOS
              ? ThemeData.light().textTheme.copyWith(
                    headline1: TextStyle(
                      fontFamily: 'Helvetica',
                      fontWeight: FontWeight.w300,
                      fontSize: 96,
                    ),
                    headline2: TextStyle(
                      fontFamily: 'Helvetica',
                      fontWeight: FontWeight.w300,
                      fontSize: 60,
                    ),
                    headline3: TextStyle(
                      fontFamily: 'Helvetica',
                      fontWeight: FontWeight.normal,
                      fontSize: 48,
                    ),
                    headline4: TextStyle(
                      fontFamily: 'Helvetica',
                      fontWeight: FontWeight.normal,
                      fontSize: 34,
                    ),
                    headline5: TextStyle(
                      fontFamily: 'Helvetica',
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                    ),
                    headline6: TextStyle(
                      fontFamily: 'Helvetica',
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                    subtitle1: TextStyle(
                      fontFamily: 'Helvetica',
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                    subtitle2: TextStyle(
                      fontFamily: 'Helvetica',
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    ),
                    button: TextStyle(
                      fontFamily: 'Helvetica',
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                  )
              : ThemeData.light().textTheme.copyWith(
                    headline1: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w300,
                      fontSize: 96,
                    ),
                    headline2: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w300,
                      fontSize: 60,
                    ),
                    headline3: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.normal,
                      fontSize: 48,
                    ),
                    headline4: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.normal,
                      fontSize: 34,
                    ),
                    headline5: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                    ),
                    headline6: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                    subtitle1: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                    subtitle2: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    ),
                    button: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                  ),
        ),
        routes: AppWireFrame.routes,
        builder: (context, child) {
          return MediaQuery(
            child: child,
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          );
        },
      ),
    );
  }
}
