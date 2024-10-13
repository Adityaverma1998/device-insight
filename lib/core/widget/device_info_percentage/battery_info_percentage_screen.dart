import 'package:device_insight/core/store/device_info/device_info_store.dart';
import 'package:device_insight/di/serivce_locators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class BatteryInfoPercentageScreen extends StatelessWidget {
  BatteryInfoPercentageScreen({super.key});

  final DeviceInfoStore _deviceInfoStore = getIt<DeviceInfoStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      // Parse battery percentage and handle null or non-numeric values
      double batteryPercentage = (double.tryParse(_deviceInfoStore.batteryInfo.batteryPercentage ?? '0') ?? 0.0) / 100;
      bool isCharging = _deviceInfoStore.batteryInfo.batteryStatus == "Charging";

      return Container(
        color: Colors.amber,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: isCharging
            ? const LinearProgressIndicator(
          minHeight: 12.0,
          borderRadius: BorderRadius.all( Radius.circular(16.0)),
          color: Colors.blue,
          backgroundColor: Colors.grey,
        )
            : LinearPercentIndicator(
          width: MediaQuery.of(context).size.width - 50,
          animation: true,
          lineHeight: 20.0,
          animationDuration: 2500,
          percent: batteryPercentage,
          center: Text(
            '${_deviceInfoStore.batteryInfo.batteryPercentage ?? '0'}%',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          barRadius: const Radius.circular(16.0),
          progressColor: Colors.green,
        ),
      );
    });
  }
}
