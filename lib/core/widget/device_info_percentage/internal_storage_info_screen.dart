import 'package:device_insight/constant/app_theme.dart';
import 'package:device_insight/constant/assets.dart';
import 'package:device_insight/core/store/device_info/device_info_store.dart';
import 'package:device_insight/di/serivce_locators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class InternalStorageInfoScreen extends StatelessWidget {
   InternalStorageInfoScreen({super.key});

  final DeviceInfoStore _deviceInfoStore = getIt<DeviceInfoStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      double totalStorage =  double.tryParse(_deviceInfoStore.memoryInfo.internalStorage ?? '0') ?? 0.0;
      double availableStorage =  double.tryParse(_deviceInfoStore.memoryInfo.availableStorage ?? '0') ?? 0.0;
      double usedStorage = totalStorage - availableStorage;

// Calculate percentage of used storage
      double usedStoragePercentage = (usedStorage / totalStorage) * 100;
      double usedStoragePercentageFormatted = double.parse( usedStoragePercentage.toStringAsFixed(2));

      int usedStoragePercentageRounded = usedStoragePercentageFormatted.round();

      print('check total used usedStoragePercentage---> $usedStoragePercentageFormatted ::: $usedStorage');
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
                  Assets.internalMemory,
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
                        'Internal Storage ',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ), ),

                    ],
                  ),
                  const SizedBox(height: 8.0),
                  LinearPercentIndicator(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    width: MediaQuery.of(context).size.width*0.7 , // Subtract padding from total width
                    animation: true,
                    lineHeight: 8.0,
                    animationDuration: 2500,
                    percent: usedStoragePercentageFormatted/100,
                    barRadius: const Radius.circular(16.0),
                    progressColor: Theme.of(context).colorScheme.primaryContainer,
                  )
                  ,
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Text(
                        'Free : ${(_deviceInfoStore.memoryInfo.availableStorage)} GB ',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ), ),
                      const SizedBox(width: 16.0),

                      Text(
                        'Total : ${(_deviceInfoStore.memoryInfo.internalStorage)} GB ',
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
            Text(
                '$usedStoragePercentageRounded%',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.primaryContainer,
                )),
          ],
        ),
      )
      ;
    });
  }

}
