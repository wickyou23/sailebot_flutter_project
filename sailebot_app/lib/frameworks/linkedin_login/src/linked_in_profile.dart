import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sailebot_app/frameworks/linkedin_login/src/linked_in_auth_response_wrapper.dart';
import 'package:sailebot_app/frameworks/linkedin_login/src/linked_in_authorization_webview.dart';
import 'package:sailebot_app/frameworks/linkedin_login/src/linked_in_user_model.dart';

/// This class is responsible to fetch all information for user after we get
/// token and code from LinkedIn
class LinkedInUserWidget extends StatefulWidget {
  final Function onGetUserProfile;
  final Function catchError;
  final String redirectUrl;
  final String clientId, clientSecret;
  final PreferredSizeWidget appBar;
  final bool destroySession;

  /// Client state parameter needs to be unique range of characters - random one
  LinkedInUserWidget({
    @required this.onGetUserProfile,
    @required this.redirectUrl,
    @required this.clientId,
    @required this.clientSecret,
    this.catchError,
    this.destroySession = false,
    this.appBar,
  });

  @override
  State createState() => _LinkedInUserWidgetState();
}

class _LinkedInUserWidgetState extends State<LinkedInUserWidget> {
  final urlLinkedInUserProfile = 'https://api.linkedin.com/v2/me';
  final urlLinkedInEmailAddress =
      'https://api.linkedin.com/v2/emailAddress?q=members&projection=(elements*(handle~))';

  @override
  Widget build(BuildContext context) => LinkedInAuthorization(
        destroySession: widget.destroySession,
        redirectUrl: widget.redirectUrl,
        clientSecret: widget.clientSecret,
        clientId: widget.clientId,
        appBar: widget.appBar,
        onCallBack: (AuthorizationCodeResponse result) {
          if (result != null && result.accessToken != null) {
            var profileDio = Dio();
            profileDio
            .get(
              urlLinkedInUserProfile,
              options: Options(headers: {
                HttpHeaders.acceptHeader: 'application/json',
                HttpHeaders.authorizationHeader:
                    'Bearer ${result.accessToken.accessToken}'
              }),
            )
            .then((basicProfile) {
              var emailDio = Dio();
              emailDio
              .get(
                urlLinkedInEmailAddress,
                options: Options(headers: {
                  HttpHeaders.acceptHeader: 'application/json',
                  HttpHeaders.authorizationHeader:
                      'Bearer ${result.accessToken.accessToken}'
                }),
              )
              .then((emailProfile) {
                final LinkedInUserModel linkedInUser =
                    LinkedInUserModel.fromJson(json.decode(basicProfile.data));
                // Get email for current user profile
                linkedInUser.email = LinkedInProfileEmail.fromJson(
                  json.decode(emailProfile.data),
                );
                linkedInUser.token = result.accessToken;

                // Notify parent class / widget that we have user
                widget.onGetUserProfile(linkedInUser);
              });
            });

            // get(
            //   urlLinkedInUserProfile,
            //   headers: {
            //     HttpHeaders.acceptHeader: 'application/json',
            //     HttpHeaders.authorizationHeader:
            //         'Bearer ${result.accessToken.accessToken}'
            //   },
            // ).then((basicProfile) {
            //   get(
            //     urlLinkedInEmailAddress,
            //     headers: {
            //       HttpHeaders.acceptHeader: 'application/json',
            //       HttpHeaders.authorizationHeader:
            //           'Bearer ${result.accessToken.accessToken}'
            //     },
            //   ).then((emailProfile) {
            //     // Get basic user profile
            //     final LinkedInUserModel linkedInUser =
            //         LinkedInUserModel.fromJson(json.decode(basicProfile.body));
            //     // Get email for current user profile
            //     linkedInUser.email = LinkedInProfileEmail.fromJson(
            //       json.decode(emailProfile.body),
            //     );
            //     linkedInUser.token = result.accessToken;

            //     // Notify parent class / widget that we have user
            //     widget.onGetUserProfile(linkedInUser);
            //   });
            // });
          } else {
            // If inner class catch the error, then forward it to parent class
            if (result.error != null && result.error.description.isNotEmpty) {
              widget.catchError(result.error);
            }
          }
        },
      );
}
