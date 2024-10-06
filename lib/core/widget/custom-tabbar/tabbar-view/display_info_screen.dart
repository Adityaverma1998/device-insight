import 'dart:async';

import 'package:device_insight/core/store/device_info/device_info_store.dart';
import 'package:device_insight/di/serivce_locators.dart';
import 'package:device_insight/mobile_tracker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class DisplayInfoScreen extends StatefulWidget {
  const DisplayInfoScreen({super.key});

  @override
  _DisplayInfoScreenState createState() => _DisplayInfoScreenState();
}

class _DisplayInfoScreenState extends State<DisplayInfoScreen> {

  final DeviceInfoStore _deviceInfoStore = getIt<DeviceInfoStore>();
  late StreamSubscription<Map<String, dynamic>> _deviceInfoSubscription;

  @override
  void initState() {
    super.initState();

    _deviceInfoSubscription = MobileTracker.deviceInfoStream.listen((deviceInfo) {
      print('check device info data before update $deviceInfo');

      _deviceInfoStore.updateDeviceInfo(deviceInfo);
    });
  }

  @override
  void dispose() {
    _deviceInfoSubscription.cancel(); // Cancel the stream subscription when the widget is disposed
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_){
      return Column(
        children: [
          Text('Current:',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(width: 2.0,),
          Text(_deviceInfoStore.deviceInfo.manufacturer),
        ],
      );

    });
  }
}
