import 'dart:async';
import 'package:flutter/services.dart';

class MobileTracker {

  static const EventChannel _batteryChannel =
  EventChannel('com.example.device_insight/battery');

  static const EventChannel _thermalChannel =
  EventChannel('com.example.device_insight/thermal');

  static const EventChannel _memoryChannel =
  EventChannel('com.example.device_insight/memory');
  static const EventChannel _deviceChannel =
  EventChannel('com.example.device_insight/deviceInfo');

  static const EventChannel _systemInfoChannel =
  EventChannel('com.example.device_insight/system_info');

  static const EventChannel _cpuInfoChannel =
  EventChannel('com.example.device_insight/cpu_usage_channel');



  static Stream<Map<String, dynamic>> get batteryInfoStream {
    return _batteryChannel
        .receiveBroadcastStream()
        .map((data) => Map<String, dynamic>.from(data));
  }

  static Stream<Map<String, dynamic>> get thermalInfoStream {
    return _thermalChannel
        .receiveBroadcastStream()
        .map((data) => Map<String, dynamic>.from(data));
  }

  static Stream<Map<String, dynamic>> get memoryInfoStream {
    return _memoryChannel
        .receiveBroadcastStream()
        .map((data) => Map<String, dynamic>.from(data));
  }

  static Stream<Map<String, dynamic>> get deviceInfoStream {
    return _deviceChannel
        .receiveBroadcastStream()
        .map((data) => Map<String, dynamic>.from(data));
  }


  static Stream<Map<String, dynamic>> get systemInfoStream {
    return _systemInfoChannel
        .receiveBroadcastStream()
        .map((data) => Map<String, dynamic>.from(data));
  }
  static Stream<Map<String, dynamic>> get cpuInfoStream {
    return _cpuInfoChannel
        .receiveBroadcastStream()
        .map((data) => Map<String, dynamic>.from(data));
  }

}
