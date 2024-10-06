package com.example.device_insight

import android.content.Context
import android.os.Handler
import android.os.Looper
import android.os.Environment
import android.os.StatFs
import android.util.DisplayMetrics
import android.view.WindowManager
import android.os.Build
import kotlin.math.sqrt
import java.io.File
import android.provider.Settings
import io.flutter.plugin.common.EventChannel
import android.util.Log
import io.flutter.plugin.common.BinaryMessenger


private val DEVICE_INFO_CHANNEL = "com.example.device_insight/deviceInfo"

class DeviceInfoStreamHandler(
    binaryMessenger: BinaryMessenger,
    private val context: Context?
) : EventChannel.StreamHandler {

    private var handler: Handler? = null
    private var runnable: Runnable? = null

    private var eventChannel: EventChannel? = null

    init {
        eventChannel = EventChannel(binaryMessenger, DEVICE_INFO_CHANNEL)
        eventChannel!!.setStreamHandler(this)
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        handler = Handler(Looper.getMainLooper())
        runnable = object : Runnable {
            override fun run() {
                val deviceInfo = getDeviceInfo()
                Log.d("DeviceInfoStreamHandler", "Device Info Map: $deviceInfo")
                events?.success(deviceInfo)
                handler?.postDelayed(this, 10000) // Update every 10 seconds
            }
        }
        handler?.post(runnable as Runnable)
    }

    override fun onCancel(arguments: Any?) {
        handler?.removeCallbacks(runnable as Runnable)
        handler = null
        runnable = null
    }

    private fun getDeviceInfo(): Map<String, String> {
        try {
            val metrics = DisplayMetrics()
            (context?.getSystemService(Context.WINDOW_SERVICE) as WindowManager).defaultDisplay.getMetrics(metrics)

            val internalStorage = getStorageInfo(Environment.getDataDirectory())
            val externalStorage = if (Environment.getExternalStorageState() == Environment.MEDIA_MOUNTED) {
                getStorageInfo(Environment.getExternalStorageDirectory())
            } else {
                mapOf("TotalStorage" to "Not available", "AvailableStorage" to "Not available")
            }

            val screenWidthInInches = metrics.widthPixels / metrics.xdpi
            val screenHeightInInches = metrics.heightPixels / metrics.ydpi
            val screenSizeInInches =
                sqrt(screenWidthInInches * screenWidthInInches + screenHeightInInches * screenHeightInInches)

            val reqString = "${Build.MANUFACTURER} ${Build.MODEL} ${Build.VERSION.RELEASE} " +
                    "${Build.VERSION_CODES::class.java.getFields()[Build.VERSION.SDK_INT].name}"


            return mapOf(
                "Model" to Build.MODEL,
                "Manufacturer" to Build.MANUFACTURER,
                "Brand" to Build.BRAND,
                "Board" to Build.BOARD,
                "Hardware" to Build.HARDWARE,
                "Host" to Build.HOST,
                "Base" to "${Build.VERSION_CODES.BASE}",
                "AndroidDeviceID" to Settings.Secure.getString(context?.contentResolver, Settings.Secure.ANDROID_ID),
                "BuildFingerprint" to Build.FINGERPRINT,
                "SDK_INT" to Build.VERSION.SDK_INT.toString(),
                "Tags" to Build.TAGS,
                "Time" to Build.TIME.toString(),
                "User" to Build.USER,
                )
        } catch (e: Exception) {
            Log.d("DeviceInfoStreamHandler", "Exception: $e")

            return mapOf(
                "error" to "$e",
            )
        }
    }

    private fun getStorageInfo(path: File): Map<String, String> {
        val statFs = StatFs(path.path)
        val blockSize = statFs.blockSizeLong
        val totalBlocks = statFs.blockCountLong
        val availableBlocks = statFs.availableBlocksLong

        // Convert storage values to GB and round to 2 decimal places
        val totalStorageGB = "%.2f".format((totalBlocks * blockSize) / (1024.0 * 1024.0 * 1024.0)) // GB
        val availableStorageGB = "%.2f".format((availableBlocks * blockSize) / (1024.0 * 1024.0 * 1024.0)) // GB

        return mapOf(
            "TotalStorage" to totalStorageGB, "AvailableStorage" to availableStorageGB
        )
    }
}
