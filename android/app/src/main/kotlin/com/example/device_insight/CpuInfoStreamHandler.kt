package com.example.device_insight

import android.content.Context
import android.opengl.GLES20
import android.os.Handler
import android.os.Looper
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.PluginRegistry.RequestPermissionsResultListener
import java.io.BufferedReader
import java.io.File
import java.io.FileInputStream
import java.io.IOException
import java.io.InputStreamReader
import android.util.Log
import java.io.FileReader

import java.io.FileNotFoundException


private val CPU_USAGE_CHANNEL = "com.example.device_insight/cpu_usage_channel"

data class Processor(
    val productName: String,
    val fab: String,
    val cpuNotation: String,
    val cpu: String,
    val gpu: String,
    val dsp: String,
    val isp: String,
    val memoryTechnology: String,
    val modem: String,
    val connectivity: String,
    val quickCharge: String,
    val released: String
)

class CpuInfoStreamHandler(
        binaryMessenger: BinaryMessenger,
) : EventChannel.StreamHandler {

    private var handler: Handler? = null
    private var runnable: Runnable? = null
    private var eventChannel: EventChannel? = null

    init {
        eventChannel = EventChannel(binaryMessenger, CPU_USAGE_CHANNEL)
        eventChannel!!.setStreamHandler(this)
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        handler = Handler(Looper.getMainLooper())

        runnable = object : Runnable {
            override fun run() {
                val cpuInfoMap = getCpuInfoAsMap()
                events?.success(cpuInfoMap)
                handler?.postDelayed(this, 5000)
            }
        }
        handler?.post(runnable as Runnable)
    }

    override fun onCancel(arguments: Any?) {
        handler?.removeCallbacks(runnable as Runnable)
        handler = null
        runnable = null
    }

    private fun getCpuInfoAsMap(): Map<String, String> {
        val cpuInfoMap = mutableMapOf<String, String>()
        try {
            val cpuInfo = readCpuInfoFromFile()
            cpuInfoMap.putAll(cpuInfo)

            // Add dynamic CPU and GPU information
            cpuInfoMap["Clock Speed"] = getClockSpeedRange()
            cpuInfoMap["Cores"] = getNumberOfCores().toString()
            cpuInfoMap["CPU Usage"] = getCpuUsage()
            cpuInfoMap["CPU Load"] = getCpuLoad()

            // Per-core clock speeds
            for (i in 0 until getNumberOfCores()) {
                cpuInfoMap["CPU $i"] = getCoreFrequency(i)
            }

            cpuInfoMap["GPU Vendor"] = getGpuVendor()
            cpuInfoMap["GPU Renderer"] = getGpuRenderer()
            cpuInfoMap["GPU Load"] = getGpuLoad()

            // Debugging: Print the CPU info map
            Log.d("CpuInfoStreamHandler", "CPU Info Map: $cpuInfoMap")

        } catch (e: IOException) {
            e.printStackTrace()
            cpuInfoMap["Error"] = "Error retrieving CPU info."
        }
        return cpuInfoMap
    }

    private fun getGpuVendor(): String {
        return GLES20.glGetString(GLES20.GL_VENDOR) ?: "Unknown"
    }

    private fun getNumberOfCores(): Int {
        return Runtime.getRuntime().availableProcessors()
    }

    private fun readCpuInfoFromFile(): Map<String, String> {
        val cpuInfoMap = mutableMapOf<String, String>()
        try {
            BufferedReader(InputStreamReader(File("/proc/cpuinfo").inputStream())).use { reader ->
                reader.lineSequence().forEach { line ->
                    val parts = line.split(":").map { it.trim() }
                    if (parts.size == 2) {
                        cpuInfoMap[parts[0]] = parts[1]
                    }
                }
            }

            cpuInfoMap["Architecture"] = cpuInfoMap["Architecture"] ?: "Not available"
//            cpuInfoMap["Processor"] = getProcessorName() ?: "Not available"
            cpuInfoMap["Processor"] =  "Not available"
            cpuInfoMap["Revision"] = cpuInfoMap["Revision"] ?: "Not available"
            cpuInfoMap["Process"] = getProcessSize()

        } catch (e: IOException) {
            e.printStackTrace()
        }
        return cpuInfoMap
    }

    private fun getProcessSize(): String {
        return try {
            getProcessSizeFromCpuInfo() ?: "Unknown"
        } catch (e: IOException) {
            "Unknown"
        }
    }

    val processorNames = mapOf(
        "MT6769V/CZ" to Processor(
            productName = "MediaTek Helio G70/G80",
            fab = "12 nm (TSMC 12FFC)",
            cpuNotation = "2 × Cortex-A75 @ 2.0 GHz, 6 × Cortex-A55 @ 1.8 GHz",
            cpu = "ARM Cortex-A55",
            gpu = "Mali-G52",
            dsp = "MediaTek APU",
            isp = "MediaTek ISP",
            memoryTechnology = "LPDDR4X",
            modem = "4G LTE",
            connectivity = "4G",
            quickCharge = "Yes",
            released = "2019"
        ),
    )

    fun getProcessorName(): Processor? {
        var processorName: String? = null
        try {
            val reader = BufferedReader(FileReader("/proc/cpuinfo"))
            var line: String?
            while (reader.readLine().also { line = it } != null) {
                if (line!!.startsWith("Hardware")) {
                    processorName = line!!.split(":")[1].trim()
                    break
                }
            }
            reader.close()
        } catch (e: IOException) {
            e.printStackTrace()
        }
        return processorName?.let { processorNames[it] }
    }
    private fun getProcessSizeFromCpuInfo(): String? {
        val cpuInfoFile = "/proc/cpuinfo"
        return try {
            BufferedReader(InputStreamReader(FileInputStream(cpuInfoFile))).use { reader ->
                reader.lineSequence().find { it.startsWith("Processor") }?.split(":")?.get(1)?.trim()
            }
        } catch (e: IOException) {
            null
        }
    }

    private fun getClockSpeedRange(): String {
        val minSpeed = getCpuMinFrequency()
        val maxSpeed = getCpuMaxFrequency()
        return if (minSpeed.isNotEmpty() && maxSpeed.isNotEmpty()) {
            "$minSpeed - $maxSpeed MHz"
        } else {
            "Not available"
        }
    }

    private fun getCpuMinFrequency(): String {
        return readCpuFrequency("/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq") ?: "Unknown"
    }

    private fun getCpuMaxFrequency(): String {
        return readCpuFrequency("/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq") ?: "Unknown"
    }

    private fun readCpuFrequency(path: String): String? {
        return try {
            BufferedReader(InputStreamReader(FileInputStream(path))).use { reader ->
                reader.readLine()?.trim()?.toIntOrNull()?.let { freq -> (freq / 1000).toString() } // Convert kHz to MHz
            }
        } catch (e: IOException) {
            null
        }
    }

    private fun getCoreFrequency(coreIndex: Int): String {
        return try {
            val path = "/sys/devices/system/cpu/cpu$coreIndex/cpufreq/scaling_cur_freq"
            val frequencyInKHz = File(path).bufferedReader().readLine()
            (frequencyInKHz?.toIntOrNull()?.div(1000)?.toString() ?: "Not available") + " MHz"
        } catch (e: IOException) {
            e.printStackTrace()
            "Not available"
        }
    }

    fun getCpuUsage(): String {
        return executeTopCommand("cpu") { cpuInfo ->
            val idleInfo = cpuInfo.find { it.contains("idle", true) }
            idleInfo?.let {
                val idlePercentage = it.replace("%idle", "").trim().toDoubleOrNull() ?: 0.0
                "${(100.0 - idlePercentage).coerceIn(0.0, 100.0)}%"
            } ?: "0%"
        }
    }

    private fun getCpuLoad(): String {
        return executeTopCommand("cpu") { cpuInfo ->
            val idleInfo = cpuInfo.find { it.contains("idle") }
            idleInfo?.let {
                val idlePercentage = idleInfo.replace("%idle", "").trim().toDoubleOrNull() ?: 0.0
                val coreCount = Runtime.getRuntime().availableProcessors()
                "${(100.0 - (idlePercentage / coreCount)).coerceIn(0.0, 100.0)}%"
            } ?: "0%"
        }
    }

    private fun executeTopCommand(keyword: String, parseCpuInfo: (List<String>) -> String): String {
        return try {
            val process = ProcessBuilder("top", "-n", "1").start()
            val output = BufferedReader(InputStreamReader(process.inputStream)).readText()
            val lines = output.split("\n")
            for (line in lines) {
                if (line.contains(keyword, true)) {
                    val cpuInfo = line.split(" ").filter { it.isNotBlank() }
                    return parseCpuInfo(cpuInfo)
                }
            }
            "0%"
        } catch (e: IOException) {
            e.printStackTrace()
            "Not available"
        }
    }

    private fun getGpuRenderer(): String {
        return GLES20.glGetString(GLES20.GL_RENDERER) ?: "Unknown Renderer"
    }

    private fun getGpuLoad(): String {
        return try {
            val gpuLoadFile = File("/sys/class/kgsl/kgsl-3d0/gpu_busy_percentage")
            if (gpuLoadFile.exists()) {
                // Attempt to read the file (this will likely fail on non-rooted devices)
                val gpuLoad = gpuLoadFile.bufferedReader().readLine()
                gpuLoad.trim() + "%" // Return the trimmed GPU load value
            } else {
                "GPU load info not available"
            }
        } catch (e: FileNotFoundException) {
            // File does not exist or is inaccessible due to permissions
//            e.printStackTrace()
            "GPU load info not available"
        } catch (e: IOException) {
            // Handle IO errors such as permission denial
//            e.printStackTrace()
            "Not available due to IO error"
        } catch (e: SecurityException) {
            // If a SecurityException occurs, it indicates restricted access to the file
//            e.printStackTrace()
            "Permission denied"
        }
    }

}
