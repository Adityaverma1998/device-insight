import 'package:device_insight/constant/app_theme.dart';
import 'package:device_insight/constant/assets.dart';
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
      double batteryPercentage = (double.tryParse(_deviceInfoStore.batteryInfo.batteryPercentage ?? '0') ?? 0.0)/100;
      bool isCharging = _deviceInfoStore.batteryInfo.batteryStatus == "Charging";

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 20.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          color:AppThemeData.lightThemeData.colorScheme.secondaryContainer,


        ),
        child: Row(
          children: [
            Container(
              // color: Colors.white,
              width: 50,
              height: 60,
              child: Image.asset(
                isCharging ? Assets.batteryCharging:  Assets.battery,
                fit: BoxFit.cover, // Image takes complete width and height
              ),
            ),
            const SizedBox(width: 10.0), // Add spacing between image and column
            Expanded( // Allows the column to expand without overflow
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
                children: [
                  Row(
                  children: [
              Text(
              'Battery${isCharging?'(Charging)':''} ',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.primaryContainer,
                ), ),

                  ],
                  ),
                  const SizedBox(height: 8.0),
                  isCharging
                      ? const LinearProgressIndicator(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    minHeight: 8.0,
                    color: Colors.blue,
                    backgroundColor: Colors.grey,
                  )
                      : LinearPercentIndicator(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        width: MediaQuery.of(context).size.width*0.64 , // Subtract padding from total width
                        animation: true,
                        lineHeight: 8.0,
                        animationDuration: 2500,
                        percent: batteryPercentage,
                        barRadius: const Radius.circular(16.0),
                        progressColor: Theme.of(context).colorScheme.primaryContainer,
                      )
                  ,
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Text(
                        'Voltage : ${_deviceInfoStore.batteryInfo.batteryVoltage} ',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ), ),
                      const SizedBox(width: 16.0),

                      Text(
                        'Temperature : ${_deviceInfoStore.batteryInfo.batteryTemperature} ',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ), ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.only(right:4.0),
              child: Text(
                        '${_deviceInfoStore.batteryInfo.batteryPercentage}%',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.primaryContainer,
                        )),
            ),
          ],
        ),
      )
      ;
    });
  }
}
