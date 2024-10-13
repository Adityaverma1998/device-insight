import 'package:device_insight/constant/assets.dart';
import 'package:device_insight/core/store/device_info/device_info_store.dart';
import 'package:device_insight/core/widget/row_table_data_widget/row_table_data_widget.dart';
import 'package:device_insight/di/serivce_locators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class DisplayInfoScreen extends StatelessWidget {
  DisplayInfoScreen({super.key});

  final DeviceInfoStore _deviceInfoStore = getIt<DeviceInfoStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return SingleChildScrollView(
        padding:
        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(16.0)),
              child: Row(
                children: [
                  SizedBox(
                    // color: Colors.white,
                    width: 50,
                    height: 60,
                    child: Image.asset(
                      Assets.mobileScreen,
                      fit:
                          BoxFit.cover, // Image takes complete width and height
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _deviceInfoStore.displayInfo.resolution,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                              height: 1.4,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                            ),
                      ),
                      Text(
                        'Built-in Screen',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                              height: 1.4,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                            ),
                      ),
                      Text(
                        '${_deviceInfoStore.displayInfo.screenSize} | ${_deviceInfoStore.displayInfo.refreshRate}',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                              height: 1.4,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                            ),
                      ),
                      Text(
                        _deviceInfoStore.displayInfo.orientation,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                              height: 1.4,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                            ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(16.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RowTableDataWidget(
                      label: 'Resolution',
                      value: _deviceInfoStore.displayInfo.resolution,
                      isDivider: true),
                  RowTableDataWidget(
                      label: 'Density',
                      value: _deviceInfoStore.displayInfo.density,
                      isDivider: true),
                  RowTableDataWidget(
                      label: 'Font Scale',
                      value: _deviceInfoStore.displayInfo.fontScale,
                      isDivider: true),
                  RowTableDataWidget(
                      label: 'Physical Size',
                      value: _deviceInfoStore.displayInfo.screenSize,
                      isDivider: true),
                  RowTableDataWidget(
                      label: 'Refresh Rate',
                      value: _deviceInfoStore.displayInfo.refreshRate,
                      isDivider: true),
                  RowTableDataWidget(
                      label: 'HDR Capabilities',
                      value: _deviceInfoStore.displayInfo.hdrCapabilities,
                      isDivider: true),
                  RowTableDataWidget(
                      label: 'Brightness Level',
                      value: _deviceInfoStore.displayInfo.brightnessLevel,
                      isDivider: true),
                  RowTableDataWidget(
                      label: 'Brightness Mode',
                      value: _deviceInfoStore.displayInfo.brightnessMode,
                      isDivider: true),
                  RowTableDataWidget(
                      label: 'Orientation',
                      value: _deviceInfoStore.displayInfo.orientation,
                      isDivider: true),
                  RowTableDataWidget(
                      label: 'Screen Timeout',
                      value: _deviceInfoStore.displayInfo.screenTimeout,
                      isDivider: false),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
