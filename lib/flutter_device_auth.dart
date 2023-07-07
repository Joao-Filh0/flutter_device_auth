
import 'package:flutter_device_auth/local_auth_enum.dart';

import 'flutter_device_auth_platform_interface.dart';

import 'package:flutter/services.dart';


class LocalAuth {
  Future<AuthStatus> biometricWithPin({required String title,
    String subTitle = '',
    String description = '',
    required String buttonText}) {
    try {
      return LocalAuthPlatform.instance.biometricWithPin(
          title: title,
          subTitle: subTitle,
          description: description,
          buttonText: buttonText);
    } on PlatformException {
      return Future.value(AuthStatus.fail);
    }
  }

  Future<AuthStatus> biometric({required String title,
    String subTitle = '',
    String description = '',
    required String buttonText}) {
    try {
      return LocalAuthPlatform.instance.biometric(
          title: title,
          subTitle: subTitle,
          description: description,
          buttonText: buttonText);
    } on PlatformException {
      return Future.value(AuthStatus.fail);
    }
  }
}

Future<AuthStatus> pin(
    {required String title, String subTitle = '', String description = ''}) {
  try {
    return LocalAuthPlatform.instance
        .pin(title: title, subTitle: subTitle, description: description);
  } on PlatformException {
    return Future.value(AuthStatus.fail);
  }
}

