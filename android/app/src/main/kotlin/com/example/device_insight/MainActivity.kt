package com.example.device_insight

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.EventChannel

class MainActivity : FlutterActivity() {
    private val BATTERY_CHANNEL = "com.example.device_insight/battery"
    private val THERMAL_CHANNEL = "com.example.device_insight/thermal"
    private val MEMORY_CHANNEL = "com.example.device_insight/memory"
    private val DEVICE_INFO_CHANNEL = "com.example.device_insight/deviceInfo"
    private val SYSTEM_INFO_CHANNEL = "com.example.device_insight/system_info"
    private val CPU_USAGE_CHANNEL = "com.example.device_insight/cpu_usage_channel"
    private val MOBILE_NETWORK_CHANNEL = "com.example.device_insight/mobileNetworkDetails"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Ensure BinaryMessenger is not null
        flutterEngine?.let { engine ->
            val binaryMessenger = engine.dartExecutor.binaryMessenger

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

            EventChannel(binaryMessenger,MOBILE_NETWORK_CHANNEL)
                .setStreamHandler(MobileNetworkStreamHandler(binaryMessenger, applicationContext))
        }
    }
}
