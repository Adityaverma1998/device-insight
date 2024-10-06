import 'dart:async';
import 'dart:developer';

import 'package:device_insight/core/store/device_info/device_info_store.dart';
import 'package:device_insight/core/widget/custom-tabbar/tabbar-view/battery_info_screen.dart';
import 'package:device_insight/core/widget/custom-tabbar/tabbar-view/display_info_screen.dart';
import 'package:device_insight/core/widget/custom-tabbar/tabbar/custom_tabbar.dart';
import 'package:device_insight/core/widget/primary_layout/primary_layout.dart';
import 'package:device_insight/di/serivce_locators.dart';
import 'package:device_insight/mobile_tracker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class HomeScreen extends StatefulWidget {
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final DeviceInfoStore _deviceInfoStore = getIt<DeviceInfoStore>();

  late StreamSubscription<Map<String, dynamic>> _batteryInfoSubscription;
  late StreamSubscription<Map<String, dynamic>> _systemInfoSubscription;
  late StreamSubscription<Map<String, dynamic>> _displayInfoSubscription;
  late StreamSubscription<Map<String, dynamic>> _cpuInfoSubscription;
   final MobileTracker _mobileTracker = MobileTracker();

  @override
  void initState() {
    super.initState();
    _startListeningToBatteryInfo();
    // log();
    // _deviceInfoStore.updateBatteryInfo()
  }

  void _startListeningToBatteryInfo() {
    _batteryInfoSubscription = MobileTracker.batteryInfoStream.listen((batteryInfo) {

      _deviceInfoStore.updateBatteryInfo(batteryInfo);
    });
    _systemInfoSubscription = MobileTracker.systemInfoStream.listen((batteryInfo) {

      // _deviceInfoStore.updateBatteryInfo(batteryInfo);
    });
    _displayInfoSubscription = MobileTracker.deviceInfoStream.listen((batteryInfo) {

      // _deviceInfoStore.updateBatteryInfo(batteryInfo);
    });
    _cpuInfoSubscription = MobileTracker.cpuInfoStream.listen((batteryInfo) {

      // _deviceInfoStore.updateBatteryInfo(batteryInfo);
    });
  }

  @override
  void dispose() {
    _batteryInfoSubscription.cancel(); // Cancel the subscription when the widget is disposed
    super.dispose();
  }

  List<String> tabLists = ['Dashboard','System'];

  @override
  Widget build(BuildContext context) {
    return PrimaryLayout(
      child: Column(
        children: [
          CustomTabbarScreen(
            tabLists: tabLists,
            tabWidgets: [BatteryInfoScreen(),DisplayInfoScreen()],
          ),
        ],
      ),
    );
  }
}

