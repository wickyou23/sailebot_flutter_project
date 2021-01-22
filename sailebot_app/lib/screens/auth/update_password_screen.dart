import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sailebot_app/screens/auth/authentication_screen.dart';
import 'package:sailebot_app/utils/extension.dart';
import 'package:sailebot_app/widgets/custom_navigation_bar.dart';
import 'package:sailebot_app/widgets/custom_textformfield.dart';

class UpdatePasswordScreen extends StatefulWidget {
  static final routeName = '/UpdatePasswordScreen';

  @override
  _UpdatePasswordScreenState createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(children: [
          OverflowBox(
            alignment: AlignmentDirectional.topCenter,
            maxHeight: context.media.size.height,
            minWidth: context.media.size.width,
            child: Image(
              image: AssetImage('assets/images/bg_screen.png'),
              fit: BoxFit.cover,
              width: context.media.size.width,
              height: context.media.size.height,
            ),
          ),
          Column(
            children: <Widget>[
              CustomNavigationBar(navTitle: 'Reset Password'),
              Expanded(
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: context.media.size.height -
                          context.media.viewPadding.top -
                          CustomNavigationBar.heightNavBar,
                    ),
                    child: IntrinsicHeight(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            SizedBox(height: 10),
                            Text(
                              'We\'ve sent you an email with a password reset code. Enter the provided code and complete the form.',
                              style: context.theme.textTheme.headline5.copyWith(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 20),
                            Form(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  CustomTextFormField(
                                    title: 'Code',
                                    placeHolder: 'Enter code...',
                                    keyboardType: TextInputType.number,
                                  ),
                                  SizedBox(height: 20),
                                  CustomTextFormField(
                                    title: 'New password',
                                    placeHolder: '••••••••',
                                    obscureText: true,
                                  ),
                                  SizedBox(height: 20),
                                  CustomTextFormField(
                                    title: 'Confirm new password',
                                    placeHolder: '••••••••',
                                    obscureText: true,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 30),
                            Container(
                              height: 50,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: RaisedButton(
                                  child: Text(
                                    'SUBMIT',
                                    style:
                                        context.theme.textTheme.button.copyWith(
                                      color: Colors.blue,
                                    ),
                                  ),
                                  color: Colors.white,
                                  onPressed: () {
                                    context.navigator.popUntil((route) {
                                      return route.settings.name ==
                                          AuthenticationScreen.routeName;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Expanded(child: Container()),
                            Container(
                              height: 60,
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: 'Code not received? ',
                                  style: context.theme.textTheme.headline5
                                      .copyWith(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                  children: [
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.baseline,
                                      baseline: TextBaseline.alphabetic,
                                      child: CupertinoButton(
                                        padding: EdgeInsets.zero,
                                        child: Text(
                                          'Resend',
                                          style: context
                                              .theme.textTheme.headline5
                                              .copyWith(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.underline,
                                            color: Colors.white,
                                          ),
                                        ),
                                        onPressed: () {},
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: context.media.viewPadding.bottom),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
