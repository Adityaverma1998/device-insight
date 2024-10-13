package com.example.device_insight

import android.os.BatteryManager
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.util.Log
import java.io.File
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.BinaryMessenger

// Define THERMAL_CHANNEL within the ThermalStreamHandler class
private const val THERMAL_CHANNEL = "com.example.device_insight/thermal"

class ThermalStreamHandler(
    private val binaryMessenger: BinaryMessenger,  // Correct order: BinaryMessenger first
    private val context: Context?
) : EventChannel.StreamHandler {

    private var batteryLevelReceiver: BroadcastReceiver? = null
    private var eventChannel: EventChannel? = null

    init {
        eventChannel = EventChannel(binaryMessenger, THERMAL_CHANNEL)
        eventChannel!!.setStreamHandler(this)
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        batteryLevelReceiver = object : BroadcastReceiver() {
            override fun onReceive(context: Context, intent: Intent) {
                val thermalData = mutableMapOf<String, String>()

                // Step 1: Get Battery Temperature
                thermalData["Battery"] = getBatteryTemperature(context)

                // Step 2: Read from /sys/class/thermal/
                thermalData.putAll(readThermalZones())

                // Send the thermal data back to Flutter
                events?.success(thermalData)
            }
        }

        // Register the BroadcastReceiver to listen for battery changes
        val filter = IntentFilter(Intent.ACTION_BATTERY_CHANGED)
        context?.registerReceiver(batteryLevelReceiver, filter)
    }

    override fun onCancel(arguments: Any?) {
        batteryLevelReceiver?.let {
            context?.unregisterReceiver(it)
        }
    }

    // Function to get battery temperature using BatteryManager
    private fun getBatteryTemperature(context: Context): String {
        val batteryIntent = context.registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
        return if (batteryIntent != null) {
            val temperature = batteryIntent.getIntExtra(BatteryManager.EXTRA_TEMPERATURE, -1)
            if (temperature != -1) {
                (temperature / 10.0).toString() + " °C"  // Convert to Celsius
            } else {
                "N/A"
            }
        } else {
            "N/A"
        }
    }

    // Function to read thermal zones from /sys/class/thermal/
    private fun readThermalZones(): Map<String, String> {
        val thermalData = mutableMapOf<String, String>()

        try {
            // Iterate through thermal zones, typically named thermal_zone0, thermal_zone1, etc.
            val thermalDir = File("/sys/class/thermal/")
            val zones = thermalDir.listFiles { file -> file.name.startsWith("thermal_zone") }

            zones?.forEach { zone ->
                val tempFile = File(zone, "temp")
                val typeFile = File(zone, "type")

                if (tempFile.exists() && typeFile.exists()) {
                    val temp = tempFile.readText().trim()
                    val type = typeFile.readText().trim()
                    thermalData[type] = formatTemperature(temp)
                }
            }
        } catch (e: Exception) {
        }

        return thermalData
    }

    // Utility function to format temperature data from millidegree Celsius to Celsius
    private fun formatTemperature(temp: String): String {
        return try {
            val temperature = temp.toInt() / 1000.0  // Convert from millidegree Celsius to Celsius
            "$temperature °C"
        } catch (e: NumberFormatException) {
            "N/A"
        }
    }
}
