import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_device_auth/flutter_device_auth.dart';
import 'package:flutter_device_auth/flutter_device_auth_platform_interface.dart';
import 'package:flutter_device_auth/flutter_device_auth_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterDeviceAuthPlatform
    with MockPlatformInterfaceMixin
    implements FlutterDeviceAuthPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterDeviceAuthPlatform initialPlatform = FlutterDeviceAuthPlatform.instance;

  test('$MethodChannelFlutterDeviceAuth is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterDeviceAuth>());
  });

  test('getPlatformVersion', () async {
    FlutterDeviceAuth flutterDeviceAuthPlugin = FlutterDeviceAuth();
    MockFlutterDeviceAuthPlatform fakePlatform = MockFlutterDeviceAuthPlatform();
    FlutterDeviceAuthPlatform.instance = fakePlatform;

    expect(await flutterDeviceAuthPlugin.getPlatformVersion(), '42');
  });
}
