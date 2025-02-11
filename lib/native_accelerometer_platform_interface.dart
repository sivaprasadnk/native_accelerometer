import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'native_accelerometer_method_channel.dart';

abstract class NativeAccelerometerPlatform extends PlatformInterface {
  /// Constructs a NativeAccelerometerPlatform.
  NativeAccelerometerPlatform() : super(token: _token);

  static final Object _token = Object();

  static NativeAccelerometerPlatform _instance = MethodChannelNativeAccelerometer();

  /// The default instance of [NativeAccelerometerPlatform] to use.
  ///
  /// Defaults to [MethodChannelNativeAccelerometer].
  static NativeAccelerometerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NativeAccelerometerPlatform] when
  /// they register themselves.
  static set instance(NativeAccelerometerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
