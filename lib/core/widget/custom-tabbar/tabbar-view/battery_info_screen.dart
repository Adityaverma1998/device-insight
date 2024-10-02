import 'package:device_insight/mobile_tracker.dart';
import 'package:flutter/material.dart';


class BatteryInfoScreen extends StatefulWidget {
  @override
  State<BatteryInfoScreen> createState() => _BatteryInfoScreenState();
}

class _BatteryInfoScreenState extends State<BatteryInfoScreen> {

  late Stream<Map<String, dynamic>> _batteryInfoStream;

  @override
  void initState() {
    super.initState();
    _batteryInfoStream = MobileTracker.batteryInfoStream;  // Battery info stream
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _batteryInfoStream.listen((batteryInfo) {
      // _userStore.setBatteryInfo(batteryInfo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String, dynamic>>(
      stream: _batteryInfoStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }
        if (!snapshot.hasData) {
          return Center(child: Text("No data available"));
        }

        final deviceData = snapshot.data!;
        return SingleChildScrollView(
          child: Column(
            children: [

              // Container(
              //   decoration: BoxDecoration(
              //     color: Colo
              //   ),
              //   child: Column(
              //     children: [
              //       Row(
              //         children: [
              //
              //         ],
              //       )
              //     ]
              //   ),
              // ),
              Table(
                border: TableBorder.all(),
                children: deviceData.entries.map((entry) {
                  return TableRow(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.0),
                        color: Colors.blueGrey[50],
                        // Left side background color
                        child: Text(
                          entry.key,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        color: Colors.blueGrey[100],
                        // Right side background color
                        child: Text(
                          entry.value.toString(),
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
