import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class NativeEmailService {
  static final NativeEmailService _shared = NativeEmailService._internal();

  NativeEmailService._internal();

  factory NativeEmailService() {
    return _shared;
  }

  final nativeEmailPlatform =
      const MethodChannel('flutter.sailebotv2.nativeEmail');

  Future<void> sendEmail(Email email) async {
    try {
      await nativeEmailPlatform.invokeMethod('sendEmail', email.toJson());
    } on PlatformException catch (e) {
      throw (e.message);
    }
  }
}
