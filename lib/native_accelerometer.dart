import 'dart:async';

import 'package:flutter/services.dart';

class NativeAccelerometer {
  static const EventChannel _eventChannel =
      EventChannel('native_accelerometer');

  static const MethodChannel _methodChannel =
      MethodChannel('native_accelerometer/methods');

  static Stream<Map<String, double>> get accelerometerStream {
    return _eventChannel.receiveBroadcastStream().map((event) {
      return {
        'x': event['x'],
        'y': event['y'],
        'z': event['z'],
      };
    });
  }

  static Future<String?> getPlatformVersion() async {
    return await _methodChannel.invokeMethod<String>('getPlatformVersion');
  }

}
