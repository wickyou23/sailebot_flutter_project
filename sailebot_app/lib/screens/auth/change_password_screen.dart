import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sailebot_app/screens/auth/change_password_success_screen.dart';
import 'package:sailebot_app/utils/extension.dart';
import 'package:sailebot_app/widgets/custom_navigation_bar.dart';
import 'package:sailebot_app/widgets/custom_textformfield.dart';

class ChangePasswordScreen extends StatefulWidget {
  static final routeName = '/ChangePasswordScreen';

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
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
              CustomNavigationBar(navTitle: 'Change Password'),
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
                            SizedBox(height: 30),
                            Form(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  CustomTextFormField(
                                      title: 'Current password',
                                      placeHolder: '••••••••',
                                      obscureText: true),
                                  SizedBox(height: 20),
                                  CustomTextFormField(
                                      title: 'New password',
                                      placeHolder: '••••••••',
                                      obscureText: true),
                                  SizedBox(height: 20),
                                  CustomTextFormField(
                                      title: 'Confirm new password',
                                      placeHolder: '••••••••',
                                      obscureText: true),
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
                                    context.navigator.pushNamedAndRemoveUntil(
                                        ChangePasswordSuccessScreen.routeName,
                                        (route) => false);
                                  },
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
