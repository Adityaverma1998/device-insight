import 'package:device_insight/core/store/device_info/device_info_store.dart';
import 'package:device_insight/di/serivce_locators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CpuInfoScreen extends StatefulWidget {
  const CpuInfoScreen({super.key});

  @override
  _CpuInfoScreenState createState() => _CpuInfoScreenState();
}

class _CpuInfoScreenState extends State<CpuInfoScreen> {
  final DeviceInfoStore _deviceInfoStore = getIt<DeviceInfoStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_){
       print('check cpu usage info reutnt  ${_deviceInfoStore.cpuUsageInfo.coreSpeeds}');
      return Text('check Cpu usage info ${_deviceInfoStore.cpuUsageInfo.bogoMIPS}');
    });
  }
}
