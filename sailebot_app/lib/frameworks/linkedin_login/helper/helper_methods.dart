import 'dart:io';

import 'package:sailebot_app/frameworks/linkedin_login/src/linked_in_auth_response_wrapper.dart';

AuthorizationCodeResponse getAuthorizationCode(
    {String redirectUrl, String clientState}) {
  AuthorizationCodeResponse response;
  final List<String> parseUrl = redirectUrl.split('?');

  if (parseUrl.isNotEmpty) {
    final List<String> queryPart = parseUrl.last.split('&');

    if (queryPart.isNotEmpty && queryPart.first.startsWith('code')) {
      final List<String> codePart = queryPart.first.split('=');
      final List<String> statePart = queryPart.last.split('=');

      if (statePart[1] == clientState) {
        response = AuthorizationCodeResponse(
          code: codePart[1],
          state: statePart[1],
        );
      } else {
        AuthorizationCodeResponse(
          error: LinkedInErrorObject(
            statusCode: HttpStatus.unauthorized,
            description: 'State code is not valid: ${statePart[1]}',
          ),
          state: statePart[1],
        );
      }
    } else if (queryPart.isNotEmpty && queryPart.first.startsWith('error')) {
      response = AuthorizationCodeResponse(
        error: LinkedInErrorObject(
          statusCode: HttpStatus.unauthorized,
          description: queryPart[1].split('=')[1].replaceAll('+', ' '),
        ),
        state: queryPart[2].split('=')[1],
      );
    }
  }

  return response;
}
