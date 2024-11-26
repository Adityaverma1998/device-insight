import 'dart:async';

import 'package:device_insight/core/store/device_info/device_info_store.dart';
import 'package:device_insight/core/widget/custom-tabbar/tabbar-view/battery_info_screen.dart';
import 'package:device_insight/core/widget/custom-tabbar/tabbar-view/camera_info_screen.dart';
import 'package:device_insight/core/widget/custom-tabbar/tabbar-view/cpu_info_screen.dart';
import 'package:device_insight/core/widget/custom-tabbar/tabbar-view/dashboard_screen.dart';
import 'package:device_insight/core/widget/custom-tabbar/tabbar-view/device_info_screen.dart';
import 'package:device_insight/core/widget/custom-tabbar/tabbar-view/display_info_screen.dart';
import 'package:device_insight/core/widget/custom-tabbar/tabbar-view/memory_info_screen.dart';
import 'package:device_insight/core/widget/custom-tabbar/tabbar-view/network_screen_info.dart';
import 'package:device_insight/core/widget/custom-tabbar/tabbar-view/system_info_screen.dart';
import 'package:device_insight/core/widget/custom-tabbar/tabbar-view/thermal_info_screen.dart';
import 'package:device_insight/core/widget/custom-tabbar/tabbar/custom_tabbar.dart';
import 'package:device_insight/core/widget/custom-tabbar/tabbar/second_custom_tabbar.dart';
import 'package:device_insight/core/widget/primary_layout/primary_layout.dart';
import 'package:device_insight/di/serivce_locators.dart';
import 'package:device_insight/mobile_tracker.dart';
import 'package:flutter/cupertino.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DeviceInfoStore _deviceInfoStore = getIt<DeviceInfoStore>();

  late StreamSubscription<Map<String, dynamic>> _batteryInfoSubscription;
  late StreamSubscription<Map<String, dynamic>> _systemInfoSubscription;
  late StreamSubscription<Map<String, dynamic>> _displayInfoSubscription;
  late StreamSubscription<Map<String, dynamic>> _cpuInfoSubscription;
  late StreamSubscription<Map<String, dynamic>> _memoryInfoSubscription;
  late StreamSubscription<Map<String, dynamic>> _deviceInfoSubscription;
  late StreamSubscription<Map<String, dynamic>> _networkInfoSubscription;
  late StreamSubscription<Map<String, dynamic>> _wifiInfoSubscription;
  late StreamSubscription<Map<String, dynamic>> _thermalInfoSubscription;

  @override
  void initState() {
    super.initState();
    _startListeningToBatteryInfo();
    // log();
    // _deviceInfoStore.updateBatteryInfo()
  }

  void _startListeningToBatteryInfo() {
    _batteryInfoSubscription =
        MobileTracker.batteryInfoStream.listen((batteryInfo) {
      _deviceInfoStore.updateBatteryInfo(batteryInfo);
    });

    _systemInfoSubscription =
        MobileTracker.systemInfoStream.listen((systemInfo) {
      // _deviceInfoStore.updateBatteryInfo(batteryInfo);
      //     print('check cpu usage info data before system $cpuUsageInfo');

      _deviceInfoStore.updateSystemInfo(systemInfo);
    });
    _displayInfoSubscription =
        MobileTracker.displayInfoStream.listen((displayInfo) {
      // _deviceInfoStore.updateBatteryInfo(batteryInfo);
      _deviceInfoStore.updateDisplayInfo(displayInfo);
    });
    _cpuInfoSubscription = MobileTracker.cpuInfoStream.listen((cpuUsageInfo) {
      // _deviceInfoStore.updateBatteryInfo(batteryInfo);

      _deviceInfoStore.updateCpuUsageInfo(cpuUsageInfo);
    });

    _memoryInfoSubscription =
        MobileTracker.memoryInfoStream.listen((memoryInfo) {
      _deviceInfoStore.updateMemoryInfo(memoryInfo);

      // _deviceInfoStore.updatememoryInfo(memoryInfo);
    });

    _deviceInfoSubscription =
        MobileTracker.deviceInfoStream.listen((deviceInfo) {
      _deviceInfoStore.updateDeviceInfo(deviceInfo);

      // _deviceInfoStore.updatememoryInfo(memoryInfo);
    });

    _thermalInfoSubscription =
        MobileTracker.thermalInfoStream.listen((thermalInfo) {
      // _deviceInfoStore.updateDeviceInfo(thermalInfo);

      _deviceInfoStore.updateThermalInfo(thermalInfo);
    });

    // _wifiInfoSubscription = MobileTracker.wifiInfoStream.listen((wifiInfo) {
    //   print('check wifi  info data before update $wifiInfo');
    //   // _deviceInfoStore.updateDeviceInfo(wifiInfo);
    //
    //   // _deviceInfoStore.updatememoryInfo(memoryInfo);
    // });
    // _networkInfoSubscription =
    //     MobileTracker.networkInfoStream.listen((wifiInfo) {
    //   print('check networkInfoStream  info data before update $wifiInfo');
    //   // _deviceInfoStore.updateDeviceInfo(wifiInfo);
    //
    //   // _deviceInfoStore.updatememoryInfo(memoryInfo);
    // });
  }

  @override
  void dispose() {
    _batteryInfoSubscription.cancel();
    _systemInfoSubscription.cancel();
    _displayInfoSubscription.cancel();
    _cpuInfoSubscription.cancel();
    _memoryInfoSubscription.cancel();
    _deviceInfoSubscription.cancel();
    super.dispose();
  }

  List<String> tabLists = [
    'Dashboard',
    'System',
    'Device',
    'Display',
    'Battery',
    // 'Network',
    'Cpu',
    'Memory',
    // 'Camera',
    'Thermal',
  ];

  @override
  Widget build(BuildContext context) {
    return PrimaryLayout(
      child: Column(
        children: [
          CustomTabbarScreen(
            tabLists: tabLists,
            tabWidgets: [
              const DashboardScreen(),
              SystemInfoScreen(),
              DeviceInfoScreen(),
              DisplayInfoScreen(),
              BatteryInfoScreen(),
              // NetworkInfoScreen(),
              CpuInfoScreen(),
              MemoryInfoScreen(),
              // const CameraInfoScreen(),
              ThermalInfoScreen(),
            ],
          ),
        ],
      ),
    );
  }
}
