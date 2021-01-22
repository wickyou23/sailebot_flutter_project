import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sailebot_app/data/network_common.dart';
import 'package:sailebot_app/data/network_response_state.dart';
import 'package:sailebot_app/data/repository/auth_repository.dart';
import 'package:sailebot_app/frameworks/linked_with_login/data_model/auth_error_response.dart';
import 'package:sailebot_app/frameworks/linked_with_login/helpers/linked_in_login_helper.dart';
import 'package:sailebot_app/models/auth_user.dart';
import 'package:sailebot_app/utils/extension.dart';

class AuthMiddleware {
  static final AuthMiddleware _singleton = AuthMiddleware._internal();

  factory AuthMiddleware() {
    return _singleton;
  }

  AuthMiddleware._internal();

  Future<ResponseState> signup(
      {@required String email, @required String password}) async {
    try {
      var body = {
        'email': email,
        'password': password,
        'returnSecureToken': true
      };
      var res = await NetworkCommon().authDio.post(
            '/accounts:signUp',
            data: body,
          );
      var data = res.data as Map<String, dynamic>;
      return ResponseSuccessState(
        statusCode: res.statusCode,
        responseData: AuthUser.fromJson(value: data),
      );
    } on DioError catch (e) {
      return ResponseFailedState(
        statusCode: e.response.statusCode,
        errorMessage: e.message,
      );
    }
  }

  Future<ResponseState> signin(
      {@required String email, @required String password}) async {
    try {
      var body = {
        'email': email,
        'password': password,
        'returnSecureToken': true
      };
      var res = await NetworkCommon().authDio.post(
            '/accounts:signInWithPassword',
            data: body,
          );
      var data = res.data as Map<String, dynamic>;
      return ResponseSuccessState(
        statusCode: res.statusCode,
        responseData: AuthUser.fromJson(value: data),
      );
    } on DioError catch (e) {
      return ResponseFailedState(
        statusCode: e.response.statusCode,
        errorMessage: e.message,
      );
    }
  }

  Future<ResponseState> updateProfile(
      {@required AuthUser user, @required String name}) async {
    try {
      var body = {
        'idToken': user.id,
        'displayName': name,
        'returnSecureToken': true
      };
      var res = await NetworkCommon().authDio.post(
            '/accounts:update',
            data: body,
          );
      var data = res.data as Map<String, dynamic>;
      String userName = data['displayName'] ?? '';
      return ResponseSuccessState(
        statusCode: res.statusCode,
        responseData: user.copyWith(firstName: userName),
      );
    } on DioError catch (e) {
      return ResponseFailedState(
        statusCode: e.response.statusCode,
        errorMessage: e.message,
      );
    }
  }

  Future<ResponseState> refreshToken() async {
    try {
      var authRepo = AuthRepository();
      var user = await authRepo.getCurrentUser();
      var response = await NetworkCommon().secureTokenDio.post(
        '/token',
        data: {
          'grant_type': 'refresh_token',
          'refresh_token': user.id,
        },
      );
      var data = response.data as Map<String, dynamic> ?? {};
      if (data.isNotEmpty) {
        String newToken = data['id_token'] as String ?? '';
        String newRefreshToken = data['refresh_token'] as String ?? '';
        // double newExpiresIn = double.tryParse(data['refresh_token']);
        if (newToken.isNotEmpty && newRefreshToken.isNotEmpty) {
          var copyUser = user.copyWith(
            id: newToken,
          );
          await authRepo.setCurrentUser(copyUser);
          return ResponseSuccessState(
            statusCode: response.statusCode,
            responseData: copyUser,
          );
        }
      }

      return ResponseFailedState(
        statusCode: response.statusCode,
        errorMessage: 'Token is empty',
      );
    } on DioError catch (e) {
      return ResponseFailedState(
        statusCode: e.response.statusCode,
        errorMessage: e.message,
      );
    }
  }

  Future<ResponseState> signinWithLinkedin(BuildContext context) async {
    final linkedin = LinkedInLogin(
      context,
      clientId: '86to7t5z08xawz',
      clientSecret: 'Vh9TyLopo3mBy96t',
      redirectUri: 'https://localhost:8080/',
    );

    final appBar = AppBar(
      title: Text(
        'Linkedin Login',
        style: context.theme.textTheme.headline5,
      ),
    );
    try {
      final _ = await linkedin.loginForAccessToken(
        destroySession: true,
        appBar: appBar,
      );

      final email = await linkedin.getEmail(
        destroySession: true,
        appBar: appBar,
      );

      final profile = await linkedin.getProfile(
        destroySession: true,
        appBar: appBar,
      );

      AuthUser linkedinUser = AuthUser.initLinkedin(
        email,
        profile,
      );

      return ResponseSuccessState(
        statusCode: 200,
        responseData: linkedinUser,
      );
    } on AuthorizationErrorResponse catch (e) {
      return ResponseFailedState(
        statusCode: -1,
        errorMessage: e.errorDescription,
      );
    }
  }
}
