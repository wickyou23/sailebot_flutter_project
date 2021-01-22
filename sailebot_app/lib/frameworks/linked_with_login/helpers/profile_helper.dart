import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sailebot_app/frameworks/linked_with_login/data_model/auth_error_response.dart';
import 'package:sailebot_app/frameworks/linked_with_login/data_model/profile_error.dart';
import 'package:sailebot_app/frameworks/linked_with_login/data_model/profile_response.dart';
import 'package:sailebot_app/frameworks/linked_with_login/config/api_routes.dart';

Future<LinkedInProfile> getProfileResponse(
    {@required String accessToken}) async {
  final response = await http.get(linkedInProfileUrl,
      headers: {'Authorization': 'Bearer $accessToken'});

  if (response.statusCode == 200)
    return linkedInProfileFromJson(response.body);
  else {
    final error = profileErrorFromJson(response.body);
    throw AuthorizationErrorResponse(
        errorDescription: error.message, status: error.status);
  }
}
