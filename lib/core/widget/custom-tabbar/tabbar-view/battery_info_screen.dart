import 'package:device_insight/core/store/device_info/device_info_store.dart';
import 'package:device_insight/di/serivce_locators.dart';
import 'package:device_insight/mobile_tracker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'dart:async'; // Required for StreamSubscription

class BatteryInfoScreen extends StatefulWidget {
  const BatteryInfoScreen({super.key});

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
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
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
                        Text(_deviceInfoStore.batteryInfo.batteryStatus),
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
                        Text(_deviceInfoStore.batteryInfo.batteryCurrent),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 8.0,),
          Observer(
            builder: (_) {
              return Container(
                width: MediaQuery.of(context).size.width*1,
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRowDataWidget('Temperature',_deviceInfoStore.batteryInfo.batteryTemperature),
                    _buildRowDataWidget('Health',_deviceInfoStore.batteryInfo.batteryHealth),
                    _buildRowDataWidget('Power Source',_deviceInfoStore.batteryInfo.batteryPowerSource),
                    _buildRowDataWidget('Technology',_deviceInfoStore.batteryInfo.batteryTechnology),
                    _buildRowDataWidget('Voltage',_deviceInfoStore.batteryInfo.batteryVoltage),
                    _buildRowDataWidget('Capacity(System Data)',_deviceInfoStore.batteryInfo.batteryCapacity),
                  ],
                ),
              );
            },
          ),

        ],
      ),
    );
  }

  Widget _buildRowDataWidget(String label,String value){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(width: 2.0,),
        Text(value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),

      ],
    );
  }
}
