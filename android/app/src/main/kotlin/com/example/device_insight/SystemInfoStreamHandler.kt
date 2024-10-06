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
import java.util.Locale
import java.util.TimeZone
import android.media.MediaDrm
import java.util.UUID


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
        val systemInfoMap = mutableMapOf<String, Any>(
            "AndroidVersion" to Build.VERSION.RELEASE,
            "ApiLevel" to Build.VERSION.SDK_INT,
            "BuildNumber" to Build.VERSION.CODENAME,
            "BuildTime" to Build.TIME,
            "BuildID" to Build.ID,
            "SecurityPatchLevel" to Build.VERSION.SECURITY_PATCH,
            "BasebandVersion" to getBasebandVersion(),
            "Language" to getDeviceLanguage(),
            "TimeZone" to getDeviceTimeZone(),
            "RootAccess" to hasRootAccess(),
            "SystemUptime" to getSystemUptime(),
            "SystemAsRoot" to isSystemAsRoot(),
            "SeamlessUpdates" to hasSeamlessUpdates(),
            "DynamicPartition" to hasDynamicPartitions(),
            "ProjectTreble" to isProjectTrebleCompatible(),
            "JavaRuntime" to System.getProperty("java.version"),
            "JavaVM" to System.getProperty("java.vm.version"),
            "JavaVMStackSize" to System.getProperty("java.vm.stack.size"),
            "KernelArchitecture" to getKernelArchitecture(),
            "KernelVersion" to getKernelVersion(),
            "OpenGLES" to GLES20.glGetString(GLES20.GL_VERSION),
            "SELinux" to getSELinuxStatus(),
            "OpenSSLVersion" to getOpenSSLVersion()
        )

        // Adding DRM Information
//        systemInfoMap.putAll(getDRMInfo())

        return systemInfoMap
    }


    fun getDRMInfo(): Map<String, Any> {
        val drmInfoMap = mutableMapOf<String, Any>(
            "Vendor" to "Unknown",
            "Version" to "Unknown",
            "Description" to "Unknown",
            "Algorithm" to "Unknown",
            "SecurityLevel" to "Unknown",
            "SystemID" to "Unknown",
            "HDCPLevel" to "Unknown",
            "MaxHDCPLevel" to "Unknown",
            "UsageReportingSupport" to false
        )

        val drmSchemeUUID = UUID.fromString("edef8ba9-79d6-4ace-ffa3-83e25ec1e33c") // Widevine UUID

        try {
            // Check if the scheme is supported
            if (MediaDrm.isCryptoSchemeSupported(drmSchemeUUID)) {
                val mediaDrm = MediaDrm(drmSchemeUUID)

                drmInfoMap["Vendor"] = mediaDrm.getPropertyString(MediaDrm.PROPERTY_VENDOR) ?: "Unknown"
                drmInfoMap["Version"] = mediaDrm.getPropertyString(MediaDrm.PROPERTY_VERSION) ?: "Unknown"
                drmInfoMap["Description"] = mediaDrm.getPropertyString(MediaDrm.PROPERTY_DESCRIPTION) ?: "Unknown"
                drmInfoMap["Algorithm"] = mediaDrm.getPropertyString(MediaDrm.PROPERTY_ALGORITHMS) ?: "Unknown"

                val systemID = mediaDrm.getPropertyByteArray(MediaDrm.PROPERTY_DEVICE_UNIQUE_ID)
                drmInfoMap["SystemID"] = systemID?.joinToString("") { String.format("%02X", it) } ?: "Unknown"

                drmInfoMap["HDCPLevel"] = mediaDrm.getPropertyString("hdcp_level") ?: "Unknown"
                drmInfoMap["MaxHDCPLevel"] = mediaDrm.getPropertyString("max_hdcp_level") ?: "Unknown"

                drmInfoMap["UsageReportingSupport"] = mediaDrm.getPropertyString("usage_reporting_support") == "true"

                mediaDrm.release()
            } else {
                Log.e("DRM", "This device does not support the specified DRM scheme.")
            }
        } catch (e: Exception) {
            Log.e("SystemInfo", "Error retrieving DRM info: ${e.message}")
        }

        return drmInfoMap
    }


    private fun getBasebandVersion(): String {
        return try {
            Build.getRadioVersion() ?: "Unknown"
        } catch (e: Exception) {
            "Unknown"
        }
    }

    private fun getDeviceLanguage(): String {
        return Locale.getDefault().language
    }

    private fun getDeviceTimeZone(): String {
        return TimeZone.getDefault().id
    }

    private fun isSystemAsRoot(): Boolean {
        // Check if the system has root access
        return Build.VERSION.SDK_INT >= Build.VERSION_CODES.R && Build.MANUFACTURER == "generic"
    }

    private fun hasSeamlessUpdates(): Boolean {
        // Check if seamless updates are supported
        return try {
            val property = System.getProperty("ro.seamless.update")
            property == "true"
        } catch (e: Exception) {
            false
        }
    }

    private fun hasDynamicPartitions(): Boolean {
        // Check if dynamic partitions are supported
        return try {
            val property = System.getProperty("ro.dynamic_partitions")
            property == "true"
        } catch (e: Exception) {
            false
        }
    }

    private fun isProjectTrebleCompatible(): Boolean {
        // Check if the device is Project Treble compatible
        return try {
            val property = System.getProperty("ro.treble.enabled")
            property == "true"
        } catch (e: Exception) {
            false
        }
    }

    private fun getSELinuxStatus(): String {
        return try {
            val status = Runtime.getRuntime().exec("getenforce").inputStream.bufferedReader().readLine()
            status ?: "Unknown"
        } catch (e: Exception) {
            "Unknown"
        }
    }

    private fun getOpenSSLVersion(): String {
        return try {
            val process = Runtime.getRuntime().exec("openssl version")
            process.inputStream.bufferedReader().readLine() ?: "Unknown"
        } catch (e: Exception) {
            "Unknown"
        }
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

        // Calculate total hours, minutes, and seconds
        val totalHours = uptimeSeconds / 3600
        val minutes = (uptimeSeconds % 3600) / 60
        val seconds = uptimeSeconds % 60

        // Return formatted string
        return String.format("%02d:%02d:%02d", totalHours, minutes, seconds)
    }
}
