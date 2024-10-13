import 'package:device_insight/core/store/device_info/device_info_store.dart';
import 'package:device_insight/core/widget/row_table_data_widget/row_table_data_widget.dart';
import 'package:device_insight/di/serivce_locators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SystemInfoScreen extends StatelessWidget {

   SystemInfoScreen({super.key});
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
                RowTableDataWidget(label: 'Android Version', value:_deviceInfoStore.systemInfo.androidVersion, isDivider: true),
                RowTableDataWidget(label: 'API Level', value:_deviceInfoStore.systemInfo.apiLevel , isDivider: true),
                // RowTableDataWidget(label: 'Build Number', value: _deviceInfoStore.systemInfo.BuildNumber, isDivider: true),
                RowTableDataWidget(label: 'Build ID', value:  _deviceInfoStore.systemInfo.buildID, isDivider: true),
                RowTableDataWidget(label: 'Security Patch Level', value:  _deviceInfoStore.systemInfo.securityPatchLevel, isDivider: true),
                RowTableDataWidget(label: 'Baseband Version', value:  _deviceInfoStore.systemInfo.bootloader, isDivider: true),
                RowTableDataWidget(label: 'Language', value: _deviceInfoStore.systemInfo.language, isDivider: true),
                RowTableDataWidget(label: 'Time Zone', value: _deviceInfoStore.systemInfo.timeZone, isDivider: true),
                RowTableDataWidget(label: 'Root Access', value:_deviceInfoStore.systemInfo.rootAccess.toString(), isDivider: true),
                RowTableDataWidget(label: 'System Uptime', value: _deviceInfoStore.systemInfo.systemUptime, isDivider: true),
                RowTableDataWidget(label: 'Java Runtime', value:_deviceInfoStore.systemInfo.javaVM, isDivider: true),
                RowTableDataWidget(label: 'Java VM', value: _deviceInfoStore.systemInfo.language, isDivider: true),
                RowTableDataWidget(label: 'Kernel Version', value: _deviceInfoStore.systemInfo.kernelVersion, isDivider: false),

              ],
            ),
          ),
        );
      }
    );
  }
}
