import 'package:device_insight/core/store/device_info/device_info_store.dart';
import 'package:device_insight/core/widget/chart/ram-used-chart/ram-use-lin-chart.dart';
import 'package:device_insight/di/serivce_locators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DeviceInfoStore _deviceInfoStore = getIt<DeviceInfoStore>();

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(

      child: Observer(
        builder: (_){
          List<Widget> cpuStatusWidgets = _deviceInfoStore.cpuUsageInfo.coreSpeeds.entries.map((entry) {
            String key = entry.key;
            String value = entry.value;

            return _buildCPUStatusWidget(key, value); // Pass key and value to the widget builder
          }).toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text('CPU Status:',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.secondaryContainer,
            )),
              const SizedBox(height: 8.0,),
              Wrap(
                runSpacing: 12.0,
              spacing: 12.0,
                children: [
                  ...cpuStatusWidgets
                ],
              ),
            SizedBox(height: 16.0,),
              LineChartSample2()
          ],
          );
        },
      ),
    );
  }
  Widget _buildCPUStatusWidget(String key,String value){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      width: 92,
      decoration: BoxDecoration(
        color:Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: const BorderRadius.all(Radius.circular(8.0))
      ),
      child: Column(
        children: [
          Text(key,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.primaryContainer,
              )),
          Text(value,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.primaryContainer,
              )),
        ],
      ),
    );
  }
}

