package com.example.device_insight

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.EventChannel
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BinaryMessenger


class MainActivity : FlutterActivity() {
    companion object {
        private const val BATTERY_CHANNEL = "com.example.device_insight/battery"
        private const val THERMAL_CHANNEL = "com.example.device_insight/thermal"
        private const val MEMORY_CHANNEL = "com.example.device_insight/memory"
        private const val DEVICE_INFO_CHANNEL = "com.example.device_insight/deviceInfo"
        private const val SYSTEM_INFO_CHANNEL = "com.example.device_insight/system_info"
        private const val CPU_USAGE_CHANNEL = "com.example.device_insight/cpu_usage_channel"
        private const val MOBILE_NETWORK_CHANNEL = "com.example.device_insight/mobileNetworkDetails"
        private const val DISPLAY_INFO_CHANNEL = "com.example.device_insight/displayInfo"
        private const val WIFI_CHANNEL = "com.example.device_insight/wifi"

    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val binaryMessenger = flutterEngine.dartExecutor.binaryMessenger

        EventChannel(binaryMessenger, BATTERY_CHANNEL)
            .setStreamHandler(BatteryStreamHandler(applicationContext))

        EventChannel(binaryMessenger, THERMAL_CHANNEL)
            .setStreamHandler(ThermalStreamHandler(binaryMessenger, applicationContext))

        EventChannel(binaryMessenger, MEMORY_CHANNEL)
            .setStreamHandler(MemoryStreamHandler(binaryMessenger, applicationContext))

        EventChannel(binaryMessenger, DEVICE_INFO_CHANNEL)
            .setStreamHandler(DeviceInfoStreamHandler(binaryMessenger, applicationContext))

        EventChannel(binaryMessenger, SYSTEM_INFO_CHANNEL)
            .setStreamHandler(SystemInfoStreamHandler(binaryMessenger, applicationContext))

        EventChannel(binaryMessenger, CPU_USAGE_CHANNEL)
            .setStreamHandler(CpuInfoStreamHandler(binaryMessenger))

        EventChannel(binaryMessenger, MOBILE_NETWORK_CHANNEL)
            .setStreamHandler(MobileNetworkStreamHandler(binaryMessenger, applicationContext))

        EventChannel(binaryMessenger, DISPLAY_INFO_CHANNEL)
            .setStreamHandler(DisplayInfoStreamHandler(binaryMessenger, applicationContext))
        EventChannel(binaryMessenger, WIFI_CHANNEL)
            .setStreamHandler(WifiStreamHandler(binaryMessenger, applicationContext))
    }
}
