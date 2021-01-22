import 'package:flutter/foundation.dart';
import 'package:sailebot_app/frameworks/linked_with_login/data_model/email_response.dart';
import 'package:sailebot_app/frameworks/linked_with_login/data_model/profile_response.dart';

class AuthUser {
  static const idKey = 'id';
  static const firstNameKey = 'firstname';
  static const lastNameKey = 'lastname';
  static const emailKey = 'email';
  static const passwordKey = 'password';
  static const genderKey = 'gender';
  static const industryKey = 'industry';
  static const productsServicesKey = 'products_services';
  static const avatarKey = 'avatar';

  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String gender;
  final String industry;
  final String productsServices;
  final String avatar;

  AuthUser._internal(
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.password,
    this.gender,
    this.industry,
    this.productsServices,
    this.avatar,
  );

  factory AuthUser.fromJson({@required Map<String, dynamic> value}) {
    return AuthUser._internal(
        value[idKey],
        value[emailKey],
        value[firstNameKey],
        value[lastNameKey],
        value[passwordKey],
        value[genderKey],
        value[industryKey],
        value[productsServicesKey],
        '');
  }

  factory AuthUser.initLinkedin(LinkedInEmail email, LinkedInProfile profile) {
    String emailString = email.elements.first.elementHandle.emailAddress ?? '';
    String firstName = profile.firstName.localized.enUs ?? '';
    String lastName = profile.lastName.localized.enUs ?? '';
    String avatar = profile.profilePicture.profilePictureDisplayImage.elements
        .first.identifiers.first.identifier ?? '';
    return AuthUser._internal(
      '',
      emailString,
      firstName,
      lastName,
      '',
      '',
      '',
      '',
      avatar,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      idKey: this.id,
      firstNameKey: this.firstName,
      lastNameKey: this.lastName,
      emailKey: this.email,
      passwordKey: this.password,
      genderKey: this.gender,
      industryKey: this.industry,
      productsServicesKey: this.productsServices,
      avatarKey: this.avatar,
    };
  }

  AuthUser copyWith({
    String id,
    String firstName,
    String lastName,
    String email,
    String password,
    String gender,
    String industry,
    String productsServices,
    String avatar,
  }) {
    return AuthUser._internal(
      id ?? this.id,
      firstName ?? this.firstName,
      lastName ?? this.lastName,
      email ?? this.email,
      password ?? this.password,
      gender ?? this.gender,
      industry ?? this.industry,
      productsServices ?? this.productsServices,
      avatar ?? this.avatar,
    );
  }
}
