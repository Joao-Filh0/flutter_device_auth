import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_device_auth_platform_interface.dart';

/// An implementation of [FlutterDeviceAuthPlatform] that uses method channels.
class MethodChannelFlutterDeviceAuth extends FlutterDeviceAuthPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_device_auth');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
