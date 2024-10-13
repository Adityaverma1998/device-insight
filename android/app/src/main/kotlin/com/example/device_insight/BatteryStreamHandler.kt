package com.example.device_insight

import android.content.Context
import android.content.BroadcastReceiver
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import io.flutter.plugin.common.EventChannel
import java.io.File
import android.util.Log

class BatteryStreamHandler(private val context: Context) : EventChannel.StreamHandler {
    private var batteryLevelReceiver: BroadcastReceiver? = null

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        batteryLevelReceiver = object : BroadcastReceiver() {
            override fun onReceive(context: Context, intent: Intent) {
                val batteryLevel = intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1)
                val batteryScale = intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
                val batteryTemperature = intent.getIntExtra(BatteryManager.EXTRA_TEMPERATURE, -1)
                val batteryVoltage = intent.getIntExtra(BatteryManager.EXTRA_VOLTAGE, -1)
                val batteryHealth = intent.getIntExtra(BatteryManager.EXTRA_HEALTH, -1)
                val batteryPowerSource = intent.getIntExtra(BatteryManager.EXTRA_PLUGGED, -1)
                val batteryStatus = intent.getIntExtra(BatteryManager.EXTRA_STATUS, -1)
                val batteryTechnology = intent.getStringExtra(BatteryManager.EXTRA_TECHNOLOGY)

                val batteryPercentage = if (batteryLevel != -1 && batteryScale != -1) {
                    (batteryLevel / batteryScale.toFloat() * 100).toInt()
                } else {
                    -1
                }

                val health = when (batteryHealth) {
                    BatteryManager.BATTERY_HEALTH_GOOD -> "Good"
                    BatteryManager.BATTERY_HEALTH_OVERHEAT -> "Overheat"
                    BatteryManager.BATTERY_HEALTH_DEAD -> "Dead"
                    BatteryManager.BATTERY_HEALTH_OVER_VOLTAGE -> "Over Voltage"
                    BatteryManager.BATTERY_HEALTH_UNSPECIFIED_FAILURE -> "Unspecified Failure"
                    else -> "Unknown"
                }

                val powerSource = when (batteryPowerSource) {
                    BatteryManager.BATTERY_PLUGGED_AC -> "AC"
                    BatteryManager.BATTERY_PLUGGED_USB -> "USB"
                    BatteryManager.BATTERY_PLUGGED_WIRELESS -> "Wireless"
                    else -> "None"
                }

                val status = when (batteryStatus) {
                    BatteryManager.BATTERY_STATUS_CHARGING -> "Charging"
                    BatteryManager.BATTERY_STATUS_DISCHARGING -> "Discharging"
                    BatteryManager.BATTERY_STATUS_FULL -> "Full"
                    BatteryManager.BATTERY_STATUS_NOT_CHARGING -> "Not Charging"
                    BatteryManager.BATTERY_STATUS_UNKNOWN -> "Unknown"
                    else -> "Unknown"
                }

                // Fetch battery current (in mA) and capacity (in mAh)
                val batteryCurrent = getBatteryCurrentNow(context)
                val batteryCapacity = getBatteryCapacity()

                events?.success(
                    mapOf(
                        "BatteryLevel" to "$batteryPercentage", // Added unit
                        "Temperature" to "${batteryTemperature / 10.0}°C", // Converted to Celsius and added unit
                        "Voltage" to "${batteryVoltage / 1000.0}V", // Converted to Volts and added unit
                        "BatteryHealth" to health,
                        "BatteryPowerSource" to powerSource,
                        "BatteryStatus" to status,
                        "Technology" to (batteryTechnology ?: "Unknown"),
                        "BatteryCurrent" to "${batteryCurrent}mA", // Added unit
                        "BatteryCapacity" to "${batteryCapacity}mAh" // Added unit
                    )
                )
            }
        }

        val batteryIntentFilter = IntentFilter(Intent.ACTION_BATTERY_CHANGED)
        context.registerReceiver(batteryLevelReceiver, batteryIntentFilter)
    }

    override fun onCancel(arguments: Any?) {
        batteryLevelReceiver?.let {
            context.unregisterReceiver(it)
        }
    }

    private fun getBatteryCurrentNow(context: Context): Double {
        val batteryManager = context.getSystemService(Context.BATTERY_SERVICE) as BatteryManager
        val currentInMicroAmps = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CURRENT_NOW)

        if (currentInMicroAmps == 0) {
            Log.e("BatteryInfo", "Battery current information not available.")
            return -1.0
        }

        val currentInMilliAmps = currentInMicroAmps.toDouble() / 1000.0
        Log.d("BatteryInfo", "Battery current: $currentInMilliAmps mA")
        return currentInMilliAmps
    }

    private fun getBatteryCapacity(): Int {
        val capacityFile = File("/sys/class/power_supply/battery/charge_full")
        if (!capacityFile.exists()) {
            Log.e("BatteryInfo", "charge_full file not found")
            return -2  // File not found
        }

        return try {
            val content = capacityFile.readText().trim()
            Log.d("BatteryInfo", "charge_full file content: $content")
            content.toIntOrNull()?.div(1000) ?: -1  // Convert from μAh to mAh
        } catch (e: Exception) {
            Log.e("BatteryInfo", "Error reading charge_full file: ${e.message}")
            e.printStackTrace()
            -1  // Return -1 if there's an error
        }
    }
}
