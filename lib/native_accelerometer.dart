
import 'native_accelerometer_platform_interface.dart';

class NativeAccelerometer {
  Future<String?> getPlatformVersion() {
    return NativeAccelerometerPlatform.instance.getPlatformVersion();
  }
}
