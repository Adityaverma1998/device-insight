import 'dart:async';
import 'dart:developer';

import 'package:device_insight/core/store/device_info/device_info_store.dart';
import 'package:device_insight/core/widget/custom-tabbar/tabbar-view/battery_info_screen.dart';
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
  late Stream<Map<String, dynamic>> _batteryInfoStream;

  final DeviceInfoStore _deviceInfoStore = getIt<DeviceInfoStore>();

  late StreamSubscription<Map<String, dynamic>> _batteryInfoSubscription;
   final MobileTracker _mobileTracker = MobileTracker();

  @override
  void initState() {
    super.initState();
    _startListeningToBatteryInfo();
    // log();
    // _deviceInfoStore.updateBatteryInfo()
  }

  void _startListeningToBatteryInfo() {
    _batteryInfoSubscription = MobileTracker.batteryInfoStream.listen(
          (batteryInfo) {

            print('check battery info Stream listen $batteryInfo');
        if (batteryInfo.isNotEmpty) {
          try {
            _deviceInfoStore.updateBatteryInfo(batteryInfo);
            setState(() {}); // Trigger UI update
          } catch (error) {
            print('Error in processing battery info: $error');
          }
        } else {
          print('Received empty battery info.');
        }
      },
      onError: (error) {
        print('Error occurred in batteryInfoStream: $error');
      },
      onDone: () {
        print('Stream closed');
      },
      cancelOnError: true,
    );
  }

  @override
  void dispose() {
    _batteryInfoSubscription.cancel(); // Cancel the subscription when the widget is disposed
    super.dispose();
  }

  List<String> tabLists = ['Dashboard'];

  @override
  Widget build(BuildContext context) {
    return PrimaryLayout(
      child: Column(
        children: [
          CustomTabbarScreen(
            tabLists: tabLists,
            tabWidgets: [BatteryInfoScreen()],
          ),
        ],
      ),
    );
  }
}

