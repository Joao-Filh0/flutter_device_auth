import 'package:flutter_device_auth/local_auth_enum.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_device_auth_method_channel.dart';

abstract class LocalAuthPlatform {
  static LocalAuthPlatform instance = MethodChannelLocalAuth();

  Future<AuthStatus> biometricWithPin(
      {required String title,
        required String subTitle,
        required String description,
        required String buttonText}) {
    throw UnimplementedError('test() has not been implemented.');
  }

  Future<AuthStatus> biometric(
      {required String title,
        required String subTitle,
        required String description,
        required String buttonText}) {
    throw UnimplementedError('test() has not been implemented.');
  }

  Future<AuthStatus> pin(
      {required String title,
        required String subTitle,
        required String description}) {
    throw UnimplementedError('test() has not been implemented.');
  }
}
