package com.example.device_insight

import android.opengl.GLES20
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.os.SystemClock
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.PluginRegistry.RequestPermissionsResultListener
import java.io.RandomAccessFile

import android.util.Log
import android.content.Context

private val SYSTEM_INFO_CHANNEL = "com.example.device_insight/system_info"

class SystemInfoStreamHandler(
        binaryMessenger: BinaryMessenger,
        private val context: Context?
) : EventChannel.StreamHandler {

    private val systemInfo = SystemInfo(context)
    private var eventChannel: EventChannel? = null
    private var handler: Handler? = null
    private var runnable: Runnable? = null

    init {
        eventChannel = EventChannel(binaryMessenger, SYSTEM_INFO_CHANNEL)
        eventChannel!!.setStreamHandler(this)
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        // Start sending system info updates every second
        handler = Handler(Looper.getMainLooper())
        runnable = object : Runnable {
            override fun run() {
                var systemInfoMap = systemInfo.getSystemInfo()
                    Log.d("SystemInfoStreamHandler", "System Info Map: $systemInfoMap")
                events?.success(systemInfoMap) // Send all system info every second
                handler?.postDelayed(this, 1000) // Update every second
            }
        }
        handler?.post(runnable!!)
    }

    override fun onCancel(arguments: Any?) {
        // Stop the updates when no longer listening
        handler?.removeCallbacks(runnable!!)
        handler = null
        runnable = null
    }
}

class SystemInfo(private val context: Context?) {

    fun getSystemInfo(): Map<String, Any> {
        return mapOf(
                "AndroidVersion" to Build.VERSION.RELEASE,
                "ApiLevel" to Build.VERSION.SDK_INT,
                "SecurityPatchLevel" to Build.VERSION.SECURITY_PATCH,
                "Bootloader" to Build.BOOTLOADER,
                "BuildID" to Build.ID,
                "JavaVM" to System.getProperty("java.vm.version"),
                "OpenGL_ES" to GLES20.glGetString(GLES20.GL_VERSION),
                "KernelArchitecture" to getKernelArchitecture(),
                "KernelVersion" to getKernelVersion(),
                "RootAccess" to hasRootAccess(),
                "GooglePlayServices" to hasGooglePlayServices(),
                "SystemUptime" to getSystemUptime()
        )
    }

    private fun getKernelArchitecture(): String {
        return try {
            RandomAccessFile("/proc/cpuinfo", "r").use { reader ->
                val architectureLine = reader.readLine()
                architectureLine?.split(":")?.get(1)?.trim() ?: "Unknown"
            }
        } catch (e: Exception) {
            "Unknown"
        }
    }

    private fun getKernelVersion(): String {
        return try {
            RandomAccessFile("/proc/version", "r").use { reader ->
                val versionLine = reader.readLine()
                versionLine?.split(" ")?.get(2) ?: "Unknown"
            }
        } catch (e: Exception) {
            "Unknown"
        }
    }

    private fun hasRootAccess(): Boolean {
        return try {
            val process = Runtime.getRuntime().exec("su")
            process.inputStream.close()
            process.errorStream.close()
            process.outputStream.close()
            process.waitFor() == 0
        } catch (e: Exception) {
            false
        }
    }

    private fun hasGooglePlayServices(): Boolean {
        return try {
            context?.packageManager?.getPackageInfo("com.google.android.gms", 0) != null
        } catch (e: Exception) {
            false
        }
    }

    fun getSystemUptime(): String {
        // Get uptime in seconds
        val uptimeSeconds = SystemClock.uptimeMillis() / 1000

        // Calculate days, hours, minutes, and seconds
        val days = uptimeSeconds / (24 * 3600)
        val hours = (uptimeSeconds % (24 * 3600)) / 3600
        val minutes = (uptimeSeconds % (24 * 3600) % 3600) / 60
        val seconds = uptimeSeconds % 60

        // Return formatted string
        return "${days} days ${hours} h:${minutes} m:${seconds} s"
    }
}
