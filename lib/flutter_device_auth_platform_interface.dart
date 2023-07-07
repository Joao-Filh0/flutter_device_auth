import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_device_auth_method_channel.dart';

abstract class FlutterDeviceAuthPlatform extends PlatformInterface {
  /// Constructs a FlutterDeviceAuthPlatform.
  FlutterDeviceAuthPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterDeviceAuthPlatform _instance = MethodChannelFlutterDeviceAuth();

  /// The default instance of [FlutterDeviceAuthPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterDeviceAuth].
  static FlutterDeviceAuthPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterDeviceAuthPlatform] when
  /// they register themselves.
  static set instance(FlutterDeviceAuthPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
