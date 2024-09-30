package com.example.device_insight

import android.content.Context
import android.os.Environment
import android.os.Handler
import android.os.Looper
import android.app.ActivityManager
import android.os.StatFs
import io.flutter.plugin.common.EventChannel
import java.io.File
import android.util.Log
import io.flutter.plugin.common.BinaryMessenger

private val MEMORY_CHANNEL = "com.example.device_insight/memory"

class MemoryStreamHandler(
    binaryMessenger: BinaryMessenger,
    private val context: Context?
) : EventChannel.StreamHandler {

    private var handler: Handler? = null
    private var runnable: Runnable? = null

    private var eventChannel: EventChannel? = null

    init {
        eventChannel = EventChannel(binaryMessenger, MEMORY_CHANNEL)
        eventChannel!!.setStreamHandler(this)
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        handler = Handler(Looper.getMainLooper())
        runnable = object : Runnable {
            override fun run() {
                // Get RAM info
                val activityManager = context?.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
                val memoryInfo = ActivityManager.MemoryInfo()
                activityManager.getMemoryInfo(memoryInfo)

                // Get internal storage (ROM) info
                val internalStorageInfo = getStorageInfo(Environment.getDataDirectory())

                // Get external storage (SD card or emulated storage) info if available
                val externalStorageInfo = if (Environment.getExternalStorageState() == Environment.MEDIA_MOUNTED) {
                    getStorageInfo(Environment.getExternalStorageDirectory())
                } else {
                    mapOf("TotalStorage" to "Not available", "AvailableStorage" to "Not available")
                }

                val totalMemoryGB = "%.2f".format(memoryInfo.totalMem / (1024.0 * 1024.0 * 1024.0)) // GB
                val availableMemoryGB = "%.2f".format(memoryInfo.availMem / (1024.0 * 1024.0 * 1024.0)) // GB
                val usedMemoryGB = "%.2f".format((memoryInfo.totalMem - memoryInfo.availMem) / (1024.0 * 1024.0 * 1024.0)) // GB
                val ramType = getRamType() // Get RAM type
                val ramTechnology = getRamTechnology() // Get RAM technology

                val memoryInfoMap = mapOf(
                    "TotalMemory" to totalMemoryGB,
                    "AvailableMemory" to availableMemoryGB,
                    "UsedMemory" to usedMemoryGB,
                    "LowMemory" to memoryInfo.lowMemory.toString(),
                    "RAMType" to ramType,
                    "RAMTechnology" to ramTechnology,
                    "TotalInternalStorage" to internalStorageInfo["TotalStorage"],
                    "AvailableInternalStorage" to internalStorageInfo["AvailableStorage"],
                    "UsedInternalStoragePercentage" to internalStorageInfo["UsedPercentage"],
                    "UsedExternalStoragePercentage" to externalStorageInfo["UsedPercentage"]
                )

                Log.d("MemoryInfoStreamHandler", "Memory Info Map: $memoryInfoMap")
                events?.success(memoryInfoMap)

                // Repeat the task every 5 seconds
                handler?.postDelayed(this, 5000)
            }
        }
        handler?.post(runnable as Runnable) // Start periodic updates
    }

    override fun onCancel(arguments: Any?) {
        handler?.removeCallbacks(runnable as Runnable) // Stop updates when no longer needed
        handler = null
        runnable = null
    }

    // Helper method to get storage info and convert to GB
    private fun getStorageInfo(path: File): Map<String, String> {
        val statFs = StatFs(path.path)
        val blockSize = statFs.blockSizeLong
        val totalBlocks = statFs.blockCountLong
        val availableBlocks = statFs.availableBlocksLong

        // Convert storage values to GB and round to 2 decimal places
        val totalStorage = "%.2f".format((totalBlocks * blockSize) / (1024.0 * 1024.0 * 1024.0)) // GB
        val availableStorage = "%.2f".format((availableBlocks * blockSize) / (1024.0 * 1024.0 * 1024.0)) // GB
        val usedStoragePercentage = "%.2f".format(((totalBlocks - availableBlocks) * blockSize.toDouble() / (1024.0 * 1024.0 * 1024.0) / totalStorage.toDouble()) * 100) // Percentage

        return mapOf(
            "TotalStorage" to totalStorage,
            "AvailableStorage" to availableStorage,
            "UsedPercentage" to usedStoragePercentage
        )
    }

    private fun getRamType(): String {
        val ramType = getSystemProperty("ro.ramtype") ?: "Unknown"
        Log.d("MemoryInfoStreamHandler", "RAM Type: $ramType")
        return ramType
    }

    private fun getRamTechnology(): String {
        val ramTechnology = getSystemProperty("ro.ramtechnology") ?: "Unknown"
        Log.d("MemoryInfoStreamHandler", "RAM Technology: $ramTechnology")
        return ramTechnology
    }

    // Helper method to get system properties
    private fun getSystemProperty(key: String): String? {
        return try {
            val propertyClass = Class.forName("android.os.SystemProperties")
            val method = propertyClass.getMethod("get", String::class.java)
            method.invoke(propertyClass, key) as? String
        } catch (e: Exception) {
            Log.e("MemoryInfoStreamHandler", "Error retrieving system property for key: $key", e)
            null
        }
    }
}
