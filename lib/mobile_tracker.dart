import 'dart:async';
import 'dart:convert'; // Importing dart:convert for jsonEncode
import 'package:flutter/services.dart';

class MobileTracker {
  static const EventChannel _batteryChannel = EventChannel('com.example.device_insight/battery');
  static const EventChannel _thermalChannel = EventChannel('com.example.device_insight/thermal');
  static const EventChannel _memoryChannel = EventChannel('com.example.device_insight/memory');
  static const EventChannel _deviceChannel = EventChannel('com.example.device_insight/deviceInfo');
  static const EventChannel _systemInfoChannel = EventChannel('com.example.device_insight/system_info');
  static const EventChannel _cpuInfoChannel = EventChannel('com.example.device_insight/cpu_usage_channel');

  static const EventChannel _displayInfoChannel = EventChannel('com.example.device_insight/displayInfo');
  static const EventChannel _wifiInfoChannel = EventChannel('com.example.device_insight/wifi');
  static const EventChannel _networkInfoChannel = EventChannel('com.example.device_insight/mobileNetworkDetails');

  static Stream<Map<String, dynamic>> get batteryInfoStream {
    return _batteryChannel.receiveBroadcastStream().map((data) {
      print('Battery Info Data received: $data');
      final batteryInfo = Map<String, dynamic>.from(data); // Convert the stream data
      // Convert to JSON string
      final batteryInfoJson = jsonEncode(batteryInfo);

      print('Battery Info in JSON format: $batteryInfoJson'); // Log the JSON string
      return batteryInfo; // Returning the original Map for further use
    }).handleError((error) {
      print('Error in batteryInfoStream: $error');
    });
  }

  static Stream<Map<String, dynamic>> get thermalInfoStream {
    return _thermalChannel.receiveBroadcastStream().map((data) {
      final thermalInfo = Map<String, dynamic>.from(data);
      final thermalInfoJson = jsonEncode(thermalInfo);
      return thermalInfo; // Returning the original Map for further use
    }).handleError((error) {
      print('Error in thermalInfoStream: $error');
    });
  }

  static Stream<Map<String, dynamic>> get memoryInfoStream {
    return _memoryChannel.receiveBroadcastStream().map((data) {
      final memoryInfo = Map<String, dynamic>.from(data);
      final memoryInfoJson = jsonEncode(memoryInfo);
      return memoryInfo; // Returning the original Map for further use
    }).handleError((error) {
      print('Error in memoryInfoStream: $error');
    });
  }

  static Stream<Map<String, dynamic>> get deviceInfoStream {
    return _deviceChannel.receiveBroadcastStream().map((data) {
      final deviceInfo = Map<String, dynamic>.from(data);
      final deviceInfoJson = jsonEncode(deviceInfo);
      return deviceInfo; // Returning the original Map for further use
    }).handleError((error) {
      print('Error in deviceInfoStream: $error');
    });
  }

  static Stream<Map<String, dynamic>> get systemInfoStream {
    return _systemInfoChannel.receiveBroadcastStream().map((data) {
      print('System Info Data received: $data');
      final systemInfo = Map<String, dynamic>.from(data);
      final systemInfoJson = jsonEncode(systemInfo);
      return systemInfo; // Returning the original Map for further use
    }).handleError((error) {
      print('Error in systemInfoStream: $error');
    });
  }

  static Stream<Map<String, dynamic>> get cpuInfoStream {
    return _cpuInfoChannel.receiveBroadcastStream().map((data) {
      print('CPU Info Data received: $data');
      final cpuInfo = Map<String, dynamic>.from(data);
      final cpuInfoJson = jsonEncode(cpuInfo);
      return cpuInfo; // Returning the original Map for further use
    }).handleError((error) {
      print('Error in cpuInfoStream: $error');
    });
  }
  static Stream<Map<String, dynamic>> get displayInfoStream {
    return _displayInfoChannel.receiveBroadcastStream().map((data) {
      print('Display Info Data received: $data');
      final cpuInfo = Map<String, dynamic>.from(data);
      final cpuInfoJson = jsonEncode(cpuInfo);
      return cpuInfo; // Returning the original Map for further use
    }).handleError((error) {
      print('Error in Displ Streamay: $error');
    });
  }

  static Stream<Map<String, dynamic>> get networkInfoStream {
    return _networkInfoChannel.receiveBroadcastStream().map((data) {
      final networkInfo = Map<String, dynamic>.from(data);
      final cpuInfoJson = jsonEncode(networkInfo);
      return networkInfo; // Returning the original Map for further use
    }).handleError((error) {
      print('Error in Displ Streamay: $error');
    });
  }

  static Stream<Map<String, dynamic>> get wifiInfoStream {
    return _wifiInfoChannel.receiveBroadcastStream().map((data) {
      final networkInfo = Map<String, dynamic>.from(data);
      final cpuInfoJson = jsonEncode(networkInfo);
      return networkInfo; // Returning the original Map for further use
    }).handleError((error) {
      print('Error in Displ Streamay: $error');
    });
  }
}
