import 'package:flutter/material.dart';
import 'package:sailebot_app/screens/auth/update_password_screen.dart';
import 'package:sailebot_app/widgets/custom_navigation_bar.dart';
import 'package:sailebot_app/utils/extension.dart';
import 'package:sailebot_app/widgets/custom_textformfield.dart';

class ResetPasswordScreen extends StatefulWidget {
  static final routeName = '/ResetPasswordScreen';

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: 10),
                    Text(
                      'Please enter your email, we will send you a code to reset your password.',
                      style: context.theme.textTheme.headline5.copyWith(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 30),
                    CustomTextFormField(
                      title: 'Email',
                      placeHolder: 'e.g. abcd@gmail.com',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 40),
                    Container(
                      height: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: RaisedButton(
                          child: Text(
                            'SUBMIT',
                            style: context.theme.textTheme.button.copyWith(
                              color: Colors.blue,
                            ),
                          ),
                          color: Colors.white,
                          onPressed: () {
                            context.navigator
                                .pushNamed(UpdatePasswordScreen.routeName);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
