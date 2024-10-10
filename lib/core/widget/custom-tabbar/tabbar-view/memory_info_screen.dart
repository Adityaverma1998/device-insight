import 'dart:async';

import 'package:device_insight/core/store/device_info/device_info_store.dart';
import 'package:device_insight/di/serivce_locators.dart';
import 'package:device_insight/mobile_tracker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class MemoryInfoScreen extends StatefulWidget {
  const MemoryInfoScreen({super.key});

  @override
  _MemoryInfoScreenState createState() => _MemoryInfoScreenState();
}

class _MemoryInfoScreenState extends State<MemoryInfoScreen> {

  final DeviceInfoStore _deviceInfoStore = getIt<DeviceInfoStore>();
  late StreamSubscription<Map<String, dynamic>> _memoryInfoSubscription;

  @override
  void initState() {
    super.initState();

    _memoryInfoSubscription = MobileTracker.memoryInfoStream.listen((memoryInfo) {
      print('check memory info data before update $memoryInfo');

      // _deviceInfoStore.updatememoryInfo(memoryInfo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_){
      return Container(
        child: Text('check memory info ${_deviceInfoStore.memoryInfo.internalStorage}'),
      );

    });
  }
}
