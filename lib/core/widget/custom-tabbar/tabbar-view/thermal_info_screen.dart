import 'package:device_insight/core/store/device_info/device_info_store.dart';
import 'package:device_insight/core/widget/row_table_data_widget/row_table_data_widget.dart';
import 'package:device_insight/di/serivce_locators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ThermalInfoScreen extends StatelessWidget {

  ThermalInfoScreen({super.key});
  final DeviceInfoStore _deviceInfoStore = getIt<DeviceInfoStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Container(
          // Removed fixed height to let the container adjust to content
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(16),  // Rounded corners
          ),
          child: RowTableDataWidget(
            label: 'Battery',
            value: _deviceInfoStore.thermalInfo.battery,
            isDivider: false,
          ),
        );
      },
    );
  }
}
