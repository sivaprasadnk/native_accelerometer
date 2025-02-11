import 'package:flutter_test/flutter_test.dart';
import 'package:native_accelerometer/native_accelerometer.dart';
import 'package:native_accelerometer/native_accelerometer_platform_interface.dart';
import 'package:native_accelerometer/native_accelerometer_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockNativeAccelerometerPlatform
    with MockPlatformInterfaceMixin
    implements NativeAccelerometerPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final NativeAccelerometerPlatform initialPlatform = NativeAccelerometerPlatform.instance;

  test('$MethodChannelNativeAccelerometer is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelNativeAccelerometer>());
  });

  test('getPlatformVersion', () async {
    NativeAccelerometer nativeAccelerometerPlugin = NativeAccelerometer();
    MockNativeAccelerometerPlatform fakePlatform = MockNativeAccelerometerPlatform();
    NativeAccelerometerPlatform.instance = fakePlatform;

    expect(await nativeAccelerometerPlugin.getPlatformVersion(), '42');
  });
}
