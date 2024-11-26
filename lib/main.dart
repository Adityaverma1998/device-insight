import 'package:device_insight/di/serivce_locators.dart';
import 'package:device_insight/mobile_tracker.dart';
import 'package:device_insight/presentation/my-app.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator.configureDependencies();


  runApp(const MyApp());
}

