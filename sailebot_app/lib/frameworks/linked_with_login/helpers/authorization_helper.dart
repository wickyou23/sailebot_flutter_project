import 'package:flutter/material.dart';
import 'package:sailebot_app/frameworks/linked_with_login/config/api_routes.dart';

String getAuthorizationUrl(
    {@required String clientId,
    @required String clientSecret,
    @required String redirectUri,
    String responseType = 'code',
    String state = 'DCEeFWf45A53sdfKef424',
    String scope = 'r_liteprofile%20r_emailaddress'}) {
  return '$linkedInAuthorizationUrl?'
      'client_id=$clientId&'
      'client_secret=$clientSecret&'
      'response_type=$responseType&'
      'state=$state&'
      'scope=$scope&'
      'redirect_uri=$redirectUri';
}