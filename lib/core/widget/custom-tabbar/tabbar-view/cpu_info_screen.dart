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
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(8.0),

            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RowTableDataWidget(label: 'Processor', value: _deviceInfoStore.cpuUsageInfo.processor, isDivider: true),
                  RowTableDataWidget(label: 'Process', value: _deviceInfoStore.cpuUsageInfo.process, isDivider: true),
                  RowTableDataWidget(label: 'implementer', value: _deviceInfoStore.cpuUsageInfo.cpuImplementer, isDivider: true),
                  RowTableDataWidget(label: 'Architecture', value: _deviceInfoStore.cpuUsageInfo.architecture, isDivider: true),
                  RowTableDataWidget(label: 'Variant', value: _deviceInfoStore.cpuUsageInfo.cpuVariant, isDivider: true),
                  RowTableDataWidget(label: 'Part', value: _deviceInfoStore.cpuUsageInfo.cpuPart, isDivider: true),
                  RowTableDataWidget(label: 'Revision', value: _deviceInfoStore.cpuUsageInfo.revision.toString(), isDivider: true),
                  RowTableDataWidget(label: 'Hardware', value: _deviceInfoStore.cpuUsageInfo.hardware, isDivider: true),
                  RowTableDataWidget(label: 'Clock Speed', value: _deviceInfoStore.cpuUsageInfo.clockSpeed, isDivider: true),
                  RowTableDataWidget(label: 'Cores', value: _deviceInfoStore.cpuUsageInfo.cores, isDivider: true),
                  ..._deviceInfoStore.cpuUsageInfo.coreSpeeds.entries.map(
                        (entry) => RowTableDataWidget(
                      label: 'CPU ${entry.key}',
                      value: entry.value,
                      isDivider: true,
                    ),
                  ).toList(),
                  RowTableDataWidget(label: 'BogoMIPS', value: _deviceInfoStore.cpuUsageInfo.bogoMIPS, isDivider: false),


                ],
              ),
            ),
          );
        }
    );
  }
}
