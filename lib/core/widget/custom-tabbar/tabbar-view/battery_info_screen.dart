import 'package:device_insight/core/store/device_info/device_info_store.dart';
import 'package:device_insight/di/serivce_locators.dart';
import 'package:device_insight/mobile_tracker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'dart:async'; // Required for StreamSubscription

class BatteryInfoScreen extends StatefulWidget {
  @override
  State<BatteryInfoScreen> createState() => _BatteryInfoScreenState();
}

class _BatteryInfoScreenState extends State<BatteryInfoScreen> {
  final DeviceInfoStore _deviceInfoStore = getIt<DeviceInfoStore>();
  late StreamSubscription<Map<String, dynamic>> _batteryInfoSubscription;

  @override
  void initState() {
    super.initState();
    _batteryInfoSubscription = MobileTracker.batteryInfoStream.listen((batteryInfo) {

      _deviceInfoStore.updateBatteryInfo(batteryInfo);
    });
  }

  @override
  void dispose() {
    _batteryInfoSubscription.cancel(); // Cancel the stream subscription when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Observer(
            builder: (_) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(_deviceInfoStore.batteryInfo.batteryPercentage,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(width: 8.0,),
                        Text('${_deviceInfoStore.batteryInfo.batteryStatus}'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Current:',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(width: 2.0,),
                        Text('${_deviceInfoStore.batteryInfo.batteryCurrent}'),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          // Observer(
          //   builder: (_) {
          //     final deviceData = _deviceInfoStore.batteryInfo; // Convert store data to a map
          //     return Table(
          //       border: TableBorder.all(),
          //       children: deviceData.map((entry) {
          //         return TableRow(
          //           children: [
          //             Container(
          //               padding: EdgeInsets.all(8.0),
          //               color: Colors.blueGrey[50],
          //               child: Text(
          //                 entry.key,
          //                 style: TextStyle(color: Colors.black),
          //               ),
          //             ),
          //             Container(
          //               padding: EdgeInsets.all(8.0),
          //               color: Colors.blueGrey[100],
          //               child: Text(
          //                 entry.value.toString(),
          //                 style: TextStyle(color: Colors.blue),
          //               ),
          //             ),
          //           ],
          //         );
          //       }).toList(),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
