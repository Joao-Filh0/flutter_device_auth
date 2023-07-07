
import 'flutter_device_auth_platform_interface.dart';

class FlutterDeviceAuth {
  Future<String?> getPlatformVersion() {
    return FlutterDeviceAuthPlatform.instance.getPlatformVersion();
  }
}
