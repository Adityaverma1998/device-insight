package com.example.device_insight

import android.content.BroadcastReceiver
import android.content.Context
import android.content.IntentFilter
import android.net.wifi.WifiManager
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.PluginRegistry.RequestPermissionsResultListener
import android.os.Handler
import android.os.Looper

import android.util.Log

private const val WIFI_CHANNEL = "com.example.device_insight/wifi"

class WifiStreamHandler(
        binaryMessenger: BinaryMessenger,
        private val context: Context?
) : EventChannel.StreamHandler {

    private lateinit var handler: Handler
    private var wifiManager: WifiManager? = null
    private var wifiReceiver: BroadcastReceiver? = null
    private var eventChannel: EventChannel? = null
    private val updateInterval: Long = 1000 // 1 second

    // Store previous Wi-Fi information to detect changes
    private var previousSSID: String? = null
    private var previousBSSID: String? = null
    private var previousIPAddress: String? = null
    private var previousRSSI: Int? = null
    private var previousFrequency: Int? = null
    private var previousLinkSpeed: Int? = null

    init {
        eventChannel = EventChannel(binaryMessenger, WIFI_CHANNEL)
        eventChannel!!.setStreamHandler(this)
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        wifiManager = context?.getSystemService(Context.WIFI_SERVICE) as WifiManager
        handler = Handler(Looper.getMainLooper())

        // Define the task to be executed every second
        val wifiUpdateTask = object : Runnable {
            override fun run() {
                val wifiInfo = wifiManager?.connectionInfo
                try {
                    wifiInfo?.let {
                        if (it.networkId == -1) {
                            // Not connected to any Wi-Fi
                            events?.success(mapOf("message" to "Please connect to Wi-Fi"))
                        } else {
                            val ipAddress = it.ipAddress
                            val formattedIpAddress = String.format(
                                    "%d.%d.%d.%d",
                                    ipAddress and 0xff,
                                    ipAddress shr 8 and 0xff,
                                    ipAddress shr 16 and 0xff,
                                    ipAddress shr 24 and 0xff
                            )

                            val hasChanged = checkForChanges(
                                    ssid = it.ssid ?: "N/A",
                                    bssid = it.bssid ?: "N/A",
                                    ip = formattedIpAddress,
                                    rssi = it.rssi,
                                    frequency = it.frequency,
                                    linkSpeed = it.linkSpeed
                            )

                            if (hasChanged) {
                                events?.success(
                                        mapOf(
                                                "SSID" to (it.ssid ?: "N/A"),
                                                "BSSID" to (it.bssid ?: "N/A"),
                                                "IP" to formattedIpAddress,
                                                "WifiStrength" to "${it.rssi} dBm",
                                                "Frequency" to "${it.frequency} MHz",
                                                "LinkSpeed" to "${it.linkSpeed} Mbps"
                                        )
                                )
                            } else {
                                events?.success(
                                        mapOf(
                                                "SSID" to (it.ssid ?: "N/A"),
                                                "BSSID" to (it.bssid ?: "N/A"),
                                                "IP" to formattedIpAddress,
                                                "WifiStrength" to "${it.rssi} dBm",
                                                "Frequency" to "${it.frequency} MHz",
                                                "LinkSpeed" to "${it.linkSpeed} Mbps"
                                        )
                                )                            }
                        }
                    } ?: run {
                        events?.success(mapOf("message" to "Wi-Fi is not connected"))
                    }
                } catch (e: Exception) {
                    events?.success(mapOf("message" to "Error retrieving Wi-Fi info: ${e.message}"))
                }

                // Schedule the next execution after the specified interval
                handler.postDelayed(this, updateInterval)
            }
        }

        // Start the task immediately
        handler.post(wifiUpdateTask)

        // Register the broadcast receiver to listen for Wi-Fi changes (RSSI, network state, etc.)
        val intentFilter = IntentFilter().apply {
            addAction(WifiManager.RSSI_CHANGED_ACTION)
            addAction(WifiManager.NETWORK_STATE_CHANGED_ACTION)
        }
        wifiReceiver = object : BroadcastReceiver() {
            override fun onReceive(context: Context?, intent: android.content.Intent?) {
                // Handle Wi-Fi changes if necessary
            }
        }
        context?.registerReceiver(wifiReceiver, intentFilter)
    }

    override fun onCancel(arguments: Any?) {
        // Stop the handler from executing further
        handler.removeCallbacksAndMessages(null)

        // Unregister the broadcast receiver if necessary
        wifiReceiver?.let {
            context?.unregisterReceiver(it)
        }
        wifiReceiver = null
    }

    // Helper function to check for changes in Wi-Fi information
    private fun checkForChanges(
            ssid: String,
            bssid: String,
            ip: String,
            rssi: Int,
            frequency: Int,
            linkSpeed: Int
    ): Boolean {
        val hasChanged = ssid != previousSSID ||
                bssid != previousBSSID ||
                ip != previousIPAddress ||
                rssi != previousRSSI ||
                frequency != previousFrequency ||
                linkSpeed != previousLinkSpeed

        // Update the previous values for the next comparison
        if (hasChanged) {
            previousSSID = ssid
            previousBSSID = bssid
            previousIPAddress = ip
            previousRSSI = rssi
            previousFrequency = frequency
            previousLinkSpeed = linkSpeed
        }
        return hasChanged
    }
}
