package com.example.device_insight

import android.content.Context
import android.os.Handler
import android.os.Looper
import android.util.DisplayMetrics
import android.view.Display
import android.view.Surface
import android.view.WindowManager
import android.provider.Settings
import android.util.Log
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import kotlin.math.sqrt
import android.os.Build

class DisplayInfoStreamHandler(
    binaryMessenger: BinaryMessenger,
    private val context: Context?
) : EventChannel.StreamHandler {

    private var handler: Handler? = null
    private var runnable: Runnable? = null
    private var eventChannel: EventChannel? = null

    init {
        eventChannel = EventChannel(binaryMessenger, "com.example.device_insight/displayInfo")
        eventChannel!!.setStreamHandler(this)
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        handler = Handler(Looper.getMainLooper())
        runnable = object : Runnable {
            override fun run() {
                val deviceInfo = getDeviceInfo()
                Log.d("DisplayInfoStreamHandler", "Device Info Map: $deviceInfo")
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
            val windowManager = context?.getSystemService(Context.WINDOW_SERVICE) as WindowManager
            val display: Display = windowManager.defaultDisplay

            // Use getRealMetrics to get the actual screen resolution
            display.getRealMetrics(metrics)

            // Screen Resolution, Density, Font Scale, Refresh Rate, and Orientation
            val resolution = "${metrics.heightPixels} x  ${metrics.widthPixels} pixels"
            val density = "${metrics.densityDpi} dpi"
            val fontScale = context?.resources?.configuration?.fontScale?.toString() ?: "Unknown"
            val refreshRate = "${display.refreshRate} Hz"
            val orientation = when (display.rotation) {
                Surface.ROTATION_0 -> "Portrait"
                Surface.ROTATION_90 -> "Landscape"
                Surface.ROTATION_180 -> "Reverse Portrait"
                Surface.ROTATION_270 -> "Reverse Landscape"
                else -> "Unknown"
            }

            // Brightness Level & Mode
            val brightnessLevel = Settings.System.getInt(
                context.contentResolver,
                Settings.System.SCREEN_BRIGHTNESS, 0
            )
            val brightnessMode = when (Settings.System.getInt(
                context.contentResolver,
                Settings.System.SCREEN_BRIGHTNESS_MODE, 0
            )) {
                Settings.System.SCREEN_BRIGHTNESS_MODE_AUTOMATIC -> "Automatic"
                Settings.System.SCREEN_BRIGHTNESS_MODE_MANUAL -> "Manual"
                else -> "Unknown"
            }

            // HDR Capabilities
            val hdrCapabilities = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                val hdr = if (display.isHdr()) "HDR Supported" else "No HDR"
                hdr
            } else {
                "HDR Not Supported"
            }

            // Screen Timeout
            val screenTimeout = Settings.System.getInt(
                context.contentResolver,
                Settings.System.SCREEN_OFF_TIMEOUT, 0
            ) / 1000 // convert to seconds

            // Calculate Built-in Screen Size using getRealMetrics for accurate size
            val physicalScreenSize = calculatePhysicalScreenSize(metrics)

            return mapOf(
                "Resolution" to resolution,
                "Density" to density,
                "FontScale" to fontScale,
                "RefreshRate" to refreshRate,
                "Orientation" to orientation,
                "BrightnessLevel" to "$brightnessLevel",
                "BrightnessMode" to brightnessMode,
                "HDRCapabilities" to hdrCapabilities,
                "ScreenTimeout" to "$screenTimeout seconds",
                "ScreenSize" to "%.2f inches".format(physicalScreenSize)
            )
        } catch (e: Exception) {
            Log.d("DisplayInfoStreamHandler", "Exception: $e")
            return mapOf("error" to "$e")
        }
    }

    private fun calculatePhysicalScreenSize(metrics: DisplayMetrics): Float {
        // Using getRealMetrics ensures we have the actual pixel dimensions
        val widthInInches = metrics.widthPixels / metrics.xdpi
        val heightInInches = metrics.heightPixels / metrics.ydpi
        return sqrt(widthInInches * widthInInches + heightInInches * heightInInches).toFloat()
    }



}
