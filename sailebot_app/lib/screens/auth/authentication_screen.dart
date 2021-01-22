import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sailebot_app/screens/auth/reset_password_screen.dart';
import 'package:sailebot_app/screens/introduce/introduce_screen.dart';
import 'package:sailebot_app/services/local_store_service.dart';
import 'package:sailebot_app/utils/extension.dart';
import 'package:sailebot_app/utils/utils.dart';
import 'package:sailebot_app/widgets/custom_textformfield.dart';
import 'package:sailebot_app/widgets/search_box_widget.dart';

class AuthenticationScreen extends StatefulWidget {
  static final routeName = '/authentication';
  final bool shouldShowSignupFirst;

  AuthenticationScreen({this.shouldShowSignupFirst = true});

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordFC = FocusNode();

  bool _isSignup = true;
  bool _isRememberMe = false;
  bool _isHidePassword = true;

  @override
  void initState() {
    Utils.whiteStatusBar();
    _isSignup = this.widget.shouldShowSignupFirst;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: context.isSmallDevice,
      body: Stack(
        overflow: Overflow.clip,
        children: <Widget>[
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
          GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(minHeight: context.media.size.height),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  margin: EdgeInsets.only(
                    top: context.media.viewPadding.top +
                        (context.media.viewPadding.bottom == 0 ? 30 : 50) -
                        (context.isSmallDevice ? 20 : 10),
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          height: 60,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Text(
                                  _isSignup ? 'Sign up' : 'Sign in',
                                  style: context
                                      .theme.appBarTheme.textTheme.headline3
                                      .copyWith(
                                    fontSize: 36,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(child: Container()),
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                child: RichText(
                                  text: TextSpan(
                                    text: 'or',
                                    style: context.theme.textTheme.subtitle1
                                        .copyWith(
                                      fontSize: 13,
                                      color: Colors.white,
                                    ),
                                    children: [
                                      WidgetSpan(
                                        alignment:
                                            PlaceholderAlignment.baseline,
                                        baseline: TextBaseline.alphabetic,
                                        child: CupertinoButton(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Text(
                                            _isSignup ? 'Sign in' : 'Sign up',
                                            style: context
                                                .theme.textTheme.headline6
                                                .copyWith(
                                              color: Colors.white,
                                              fontSize: 17,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _passwordController.text = '';
                                              _isSignup = !_isSignup;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Form(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              CustomTextFormField(
                                key: ValueKey('_emailKey'),
                                controller: _emailController,
                                title: 'Email',
                                placeHolder: 'e.g. abcd@gmail.com',
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (_) {
                                  context.focus.unfocus();
                                  context.focus.requestFocus(_passwordFC);
                                },
                              ),
                              SizedBox(height: 25),
                              CustomTextFormField(
                                key: ValueKey('_passwordKey'),
                                controller: _passwordController,
                                focusNode: _passwordFC,
                                title: 'Password',
                                placeHolder: '••••••••',
                                obscureText: _isHidePassword,
                                suffixIcon: IconButton(
                                  icon: _isHidePassword
                                      ? Icon(Icons.visibility)
                                      : Icon(Icons.visibility_off),
                                  color: Colors.white,
                                  onPressed: () {
                                    _isHidePassword = !_isHidePassword;
                                    setState(() {});
                                  },
                                ),
                                onFieldSubmitted: (_) {
                                  context.focus.unfocus();
                                },
                              ),
                            ],
                          ),
                        ),
                        if (!_isSignup) ..._showRememberMe(),
                        SizedBox(height: context.isSmallDevice ? 30 : 50),
                        Container(
                          height: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: RaisedButton(
                              child: Text(
                                _isSignup ? 'SIGN UP' : 'SIGN IN',
                                style: context.theme.textTheme.button.copyWith(
                                  color: Colors.blue,
                                ),
                              ),
                              color: Colors.white,
                              onPressed: () async {
                                context.navigator.pushReplacementNamed(
                                    IntroduceScreen.routeName);
                                LocalStoreService().isSignIn = true;
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'or sign up with',
                          textAlign: TextAlign.center,
                          style: context.theme.textTheme.headline5.copyWith(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: RaisedButton(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/icon_linkedin.png',
                                    width: 20,
                                    height: 20,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'LINKEDIN',
                                    style:
                                        context.theme.textTheme.button.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              color: ColorExt.colorWithHex(0x2A69AC),
                              onPressed: () {
                                context.navigator.pushReplacementNamed(
                                    IntroduceScreen.routeName);
                                LocalStoreService().isSignIn = true;
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: (context.isSmallDevice) ? 10 : 20),
                        Expanded(child: Container()),
                        if (!_isSignup)
                          Container(
                            height: 60,
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: 'Forgot password? ',
                                style:
                                    context.theme.textTheme.headline5.copyWith(
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
                                        'Reset',
                                        style: context.theme.textTheme.headline6
                                            .copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                          color: Colors.white,
                                        ),
                                      ),
                                      onPressed: () {
                                        context.navigator.pushNamed(
                                            ResetPasswordScreen.routeName);
                                      },
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
          ),
        ],
      ),
    );
  }

  List<Widget> _showRememberMe() {
    return [
      SizedBox(height: 10),
      Row(
        children: <Widget>[
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  _isRememberMe
                      ? Icons.check_box
                      : Icons.check_box_outline_blank,
                  color: Colors.white,
                ),
                SizedBox(width: 8),
                Text(
                  'Remember me',
                  style: context.theme.textTheme.headline5.copyWith(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            onPressed: () {
              setState(() {
                _isRememberMe = !_isRememberMe;
              });
            },
          ),
          Expanded(child: Container())
        ],
      ),
    ];
  }
}
