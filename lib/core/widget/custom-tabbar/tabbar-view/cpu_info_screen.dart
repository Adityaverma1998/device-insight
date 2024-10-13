import 'package:device_insight/core/store/device_info/device_info_store.dart';
import 'package:device_insight/core/widget/row_table_data_widget/row_table_data_widget.dart';
import 'package:device_insight/di/serivce_locators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CpuInfoScreen extends StatelessWidget {

  CpuInfoScreen({super.key});
  final DeviceInfoStore _deviceInfoStore = getIt<DeviceInfoStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (context) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RowTableDataWidget(label: 'Model', value: _deviceInfoStore.deviceInfo.model, isDivider: true),
                  RowTableDataWidget(label: 'Manufacturer', value: _deviceInfoStore.deviceInfo.manufacturer, isDivider: true),
                  RowTableDataWidget(label: 'Brand', value: _deviceInfoStore.deviceInfo.brand, isDivider: true),
                  RowTableDataWidget(label: 'Board', value: _deviceInfoStore.deviceInfo.board, isDivider: true),
                  RowTableDataWidget(label: 'Hardware', value: _deviceInfoStore.deviceInfo.hardware, isDivider: true),
                  RowTableDataWidget(label: 'Host', value: _deviceInfoStore.deviceInfo.board, isDivider: true),
                  RowTableDataWidget(label: 'Base', value: _deviceInfoStore.deviceInfo.board.toString(), isDivider: true),
                  RowTableDataWidget(label: 'Android Device ID', value: _deviceInfoStore.deviceInfo.androidDeviceID, isDivider: true),
                  RowTableDataWidget(label: 'Build Fingerprint', value: _deviceInfoStore.deviceInfo.buildFingerprint, isDivider: true),
                  RowTableDataWidget(label: 'SDK INT', value: _deviceInfoStore.deviceInfo.sdkInt, isDivider: true),
                  RowTableDataWidget(label: 'Tags', value: _deviceInfoStore.deviceInfo.tags, isDivider: true),
                  RowTableDataWidget(label: 'Build Time', value: _deviceInfoStore.deviceInfo.buildFingerprint, isDivider: true),
                  RowTableDataWidget(label: 'User', value: _deviceInfoStore.deviceInfo.user, isDivider: false),

                ],
              ),
            ),
          );
        }
    );
  }
}
