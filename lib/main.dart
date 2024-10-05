import 'package:device_insight/di/serivce_locators.dart';
import 'package:device_insight/mobile_tracker.dart';
import 'package:device_insight/presentation/my-app.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator.configureDependencies();


  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Stream<Map<String, dynamic>> _batteryStream;
  late Stream<Map<String, dynamic>> _thermalStream;
  late Stream<Map<String, dynamic>> _memoryStream;
  late Stream<Map<String, dynamic>> _deviceStream;
  late Stream<Map<String, dynamic>> _systemInfoStream;
  late Stream<Map<String, dynamic>> _cpuInfoStream;

  @override
  void initState() {
    super.initState();
    _batteryStream = MobileTracker.batteryInfoStream;  // Battery info stream
    _thermalStream = MobileTracker.thermalInfoStream;  // Thermal info stream
    _memoryStream = MobileTracker.memoryInfoStream;  // Thermal info stream
    _deviceStream = MobileTracker.deviceInfoStream;  // Thermal info stream
    _deviceStream = MobileTracker.deviceInfoStream;  // Thermal info stream
    _systemInfoStream = MobileTracker.systemInfoStream;  // Thermal info stream
    _cpuInfoStream = MobileTracker.cpuInfoStream;  // Thermal info stream
  }

  // Reusable widget for StreamBuilder
  Widget buildStreamInfo(Stream<Map<String, dynamic>> stream, String title) {
    return StreamBuilder<Map<String, dynamic>>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }
        if (!snapshot.hasData) {
          return Center(child: Text("No $title data"));
        }

        final data = snapshot.data!;
        return ListTile(
          title: Text("$title Info"),
          subtitle: Text(data.toString()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Device Info"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                buildStreamInfo(_batteryStream, "Battery"),
                Divider(),  // Adds separation between Battery and Thermal sections
                buildStreamInfo(_thermalStream, "Thermal"),
                Divider(),  // Adds separation between Battery and Thermal sections
                buildStreamInfo(_memoryStream, "Memory"),
                Divider(),  // Adds separation between Battery and Thermal sections
                buildStreamInfo(_deviceStream, "Device"),
                Divider(),  // Adds separation between Battery and Thermal sections
                buildStreamInfo(_systemInfoStream, "System Info"),
                Divider(),  // Adds separation between Battery and Thermal sections
                buildStreamInfo(_cpuInfoStream, "Cpu Usage Info"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
