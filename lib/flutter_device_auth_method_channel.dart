import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_device_auth/local_auth_enum.dart';
import 'package:flutter_device_auth/local_auth_helper.dart';

import 'flutter_device_auth_platform_interface.dart';

class MethodChannelLocalAuth extends LocalAuthPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_device_auth');

  @override
  Future<AuthStatus> biometricWithPin(
      {required String title,
        required String subTitle,
        required String description,
        required String buttonText}) async {
    final biometricIsSuccess =
        await methodChannel.invokeMethod<String>('biometric', {
          'title': title,
          'subTitle': subTitle,
          'description': description,
          'buttonText': buttonText
        }) ??
            AuthStatus.notAvailable.name;

    if (biometricIsSuccess == AuthStatus.success.name) {
      return AuthStatus.success;
    }

    if (biometricIsSuccess == AuthStatus.turnPin.name ||
        biometricIsSuccess == AuthStatus.fail.name) {
      final status =
      await pin(title: title, subTitle: subTitle, description: description);

      return status;
    }
    return AuthStatus.fail;
  }

  @override
  Future<AuthStatus> biometric(
      {required String title,
        required String subTitle,
        required String description,
        required String buttonText}) async {
    final status = await methodChannel.invokeMethod<String>('biometric', {
      'title': title,
      'subTitle': subTitle,
      'description': description,
      'buttonText': buttonText
    }) ??
        AuthStatus.notAvailable.name;

    return LocalAuthHelper.select(status);
  }

  @override
  Future<AuthStatus> pin(
      {required String title,
        required String subTitle,
        String description = ''}) async {
    final status = await methodChannel.invokeMethod<String>('pin', {
      'title': title,
      'subTitle': subTitle,
      'description': description,
    }) ??
        AuthStatus.notAvailable.name;

    return LocalAuthHelper.select(status);
  }
}

