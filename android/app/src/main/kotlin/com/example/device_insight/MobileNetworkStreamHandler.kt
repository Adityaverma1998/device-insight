package com.example.device_insight

import android.Manifest
import android.content.Context
import android.content.pm.PackageManager
import android.os.Handler
import android.os.Looper
import android.telephony.*
import androidx.core.content.ContextCompat
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.PluginRegistry.RequestPermissionsResultListener
import android.util.Log

data class SignalStrengthInfo(val sim1Signal: Int?, val sim2Signal: Int?)

private val MOBILE_NETWORK_CHANNEL = "com.example.device_insight/mobileNetworkDetails"

class MobileNetworkStreamHandler(
        binaryMessenger: BinaryMessenger,
        private val context: Context?
) : EventChannel.StreamHandler {

    private var telephonyManager: TelephonyManager? = null
    private var subscriptionManager: SubscriptionManager? = null
    private var handler: Handler? = null
    private var runnable: Runnable? = null
    private var phoneStateListener: PhoneStateListener? = null
    private var eventChannel: EventChannel? = null

    init {
        eventChannel = EventChannel(binaryMessenger, MOBILE_NETWORK_CHANNEL)
        eventChannel!!.setStreamHandler(this)
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        telephonyManager = context?.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
        subscriptionManager = context?.getSystemService(Context.TELEPHONY_SUBSCRIPTION_SERVICE) as SubscriptionManager

        // Set up handler for periodic updates
        handler = Handler(Looper.getMainLooper())
        runnable = object : Runnable {
            override fun run() {
                sendNetworkInfo(events)
                handler?.postDelayed(this, 2000) // Update every 2 seconds
            }
        }
        handler?.post(runnable!!) // Non-null assertion

        // PhoneStateListener for real-time signal strength updates
        phoneStateListener = object : PhoneStateListener() {
            override fun onSignalStrengthsChanged(signalStrength: SignalStrength) {
                Log.d("MobileNetworkStreamHandler", "Signal strength changed: ${signalStrength.level}")
                sendNetworkInfo(events) // Send updated signal strengths
            }
        }

        telephonyManager?.listen(
                phoneStateListener,
                PhoneStateListener.LISTEN_SIGNAL_STRENGTHS
        )
    }

    override fun onCancel(arguments: Any?) {
        // Remove handler callbacks to avoid memory leaks
        runnable?.let { handler?.removeCallbacks(it) } // Safe call
        handler = null
        runnable = null

        // Stop listening to phone state changes
        phoneStateListener?.let {
            telephonyManager?.listen(it, PhoneStateListener.LISTEN_NONE)
        }
        phoneStateListener = null
    }

    private fun sendNetworkInfo(events: EventChannel.EventSink?) {
        try {
            telephonyManager?.let { tm ->
                val simDetails = getSimDetails()
                val signalStrengths = getSignalStrengths(context)

                val sim1SignalDbm = "${signalStrengths.sim1Signal} dBm"
                val sim2SignalDbm = "${signalStrengths.sim2Signal} dBm"

                Log.d("MobileNetworkStreamHandler", "Signal Strength SIM 1: ${signalStrengths.sim1Signal} dBm")
                Log.d("MobileNetworkStreamHandler", "Signal Strength SIM 2: ${signalStrengths.sim2Signal} dBm")


                // Identify which SIM is connected to mobile data
                val activeSimForData = getActiveSimForData()

                // Create flattened details
                val flattenedDetails = mutableMapOf<String, Any?>()

// Check and add details for SIM1 if available
                simDetails["SIM1"]?.let {
                    flattenedDetails["CarrierName_SIM1"] = it["CarrierName"]
                    flattenedDetails["DisplayName_SIM1"] = it["DisplayName"]
                    flattenedDetails["PhoneNumber_SIM1"] = it["PhoneNumber"]
                    flattenedDetails["NetworkType_SIM1"] = it["NetworkType"]
                    flattenedDetails["SignalStrength_SIM1"] = sim1SignalDbm
                }

// Check and add details for SIM2 if available
                simDetails["SIM2"]?.let {
                    flattenedDetails["CarrierName_SIM2"] = it["CarrierName"]
                    flattenedDetails["DisplayName_SIM2"] = it["DisplayName"]
                    flattenedDetails["PhoneNumber_SIM2"] = it["PhoneNumber"]
                    flattenedDetails["NetworkType_SIM2"] = it["NetworkType"]
                    flattenedDetails["SignalStrength_SIM2"] = sim2SignalDbm
                }

                flattenedDetails["ActiveSimForData"] = activeSimForData // Keep track of which SIM is connected to mobile data
                Log.d("MobileNetworkInfoStreamHandler", "Mobile Network Info Map: $flattenedDetails")
                events?.success(flattenedDetails)
            } ?: run {
                events?.error("NULL_TELEPHONY_MANAGER", "Telephony Manager is not available", null)
            }
        } catch (e: Exception) {
            Log.e("MobileNetworkStreamHandler", "Error occurred while sending network info: ${e.message}")
            events?.error("ERROR_SENDING_DATA", "Error occurred while sending network info", e.message)
        }
    }

    private fun getSignalStrengths(context: Context?): SignalStrengthInfo {
        val subscriptionManager = context?.getSystemService(Context.TELEPHONY_SUBSCRIPTION_SERVICE) as SubscriptionManager
        val activeSubscriptionInfoList = subscriptionManager.activeSubscriptionInfoList

        // Get SIM info for both slots
        val simInfoSim1 = activeSubscriptionInfoList.firstOrNull { it.simSlotIndex == 0 }
        val simInfoSim2 = activeSubscriptionInfoList.firstOrNull { it.simSlotIndex == 1 }

        val sim1Name = simInfoSim1?.carrierName?.toString() ?: "SIM 1 not available"
        val sim2Name = simInfoSim2?.carrierName?.toString() ?: "SIM 2 not available"

        Log.d("SignalStrength", "Retrieving signal strength for simInfoSim1: $sim1Name with Subscription ID: $simInfoSim1")
        Log.d("SignalStrength", "Retrieving signal strength for simInfoSim2: $sim2Name with Subscription ID: $simInfoSim2")


        // Log SIM info and subscription IDs


        // Retrieve signal strength for both SIM slots
        val signalStrengthSim1 = getSignalStrengthForSim(context, sim1Name, simInfoSim1)
        val signalStrengthSim2 = getSignalStrengthForSim(context, sim2Name, simInfoSim2)

        // Log signal strengths for both SIMs


        return SignalStrengthInfo(
                sim1Signal = signalStrengthSim1,
                sim2Signal = signalStrengthSim2
        )
    }

    private fun getSignalStrengthForSim(context: Context, simName: String, simInfo: SubscriptionInfo?): Int? {
        Log.d("SignalStrength", "simInfo: $simInfo ")

        simInfo?.let {
            val subscriptionId = it.subscriptionId
            Log.d("SignalStrength", "subscriptionId: $subscriptionId ")

            val telephonyManager = context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
            val telephonyManagerForSim = telephonyManager.createForSubscriptionId(subscriptionId)

            Log.d("SignalStrength", "telephonyManagerForSim: $telephonyManagerForSim ")

            // Additional debugging for network type and SIM state
            val networkType = telephonyManagerForSim.networkType
            Log.d("SignalStrength", "Network Type for SIM: $networkType")

            val simState = telephonyManagerForSim.simState
            Log.d("SignalStrength", "SIM State for SIM: $simState")

            val cellInfoList = telephonyManagerForSim.allCellInfo
            if (cellInfoList != null && cellInfoList.isNotEmpty()) {
                for (cellInfo in cellInfoList) {
                    Log.d("CellInfo--->:", cellInfo.toString())
                }
            } else {
                Log.d("CellInfo", "No cell info available for SIM")
            }
            // Log the cell info list
            Log.d("SignalStrength", "Retrieving signal strength for SIM: $simName with Subscription ID: $subscriptionId")
            Log.d("SignalStrength", "cellInfoList: $cellInfoList ")

            if (!cellInfoList.isNullOrEmpty()) {
                // Filter for registered cells and then for the specific SIM name
                val filteredCells = cellInfoList.filter { cellInfo ->
                    val isRegistered = cellInfo.isRegistered
                    val operatorName: String? = when (cellInfo) {
                        is CellInfoLte -> cellInfo.cellIdentity?.operatorAlphaLong?.toString()
                        is CellInfoWcdma -> cellInfo.cellIdentity?.operatorAlphaLong?.toString()
                        is CellInfoGsm -> cellInfo.cellIdentity?.operatorAlphaLong?.toString()
                        else -> null
                    }

                    val simNameLower = if (simName.contains(" ")) {
                        simName.split(" ").first().lowercase()
                    } else {
                        simName.lowercase()
                    }
                    Log.d("SignalStrength", "Checking operator name: $operatorName for SIM: $simName")

                    val operatorNameLower = operatorName?.lowercase()?.replace("-", " ")
                    Log.d("SignalStrength", "Formatted operator name: $operatorNameLower")

                    // Updated check for operator name
                    val isValidOperator = !operatorNameLower.isNullOrEmpty() && (
                            operatorNameLower.contains(simNameLower, ignoreCase = true)
                            )
                    // Log the details for debugging
                    Log.d("SignalStrength", "cellInfo: $cellInfo   Is registered: $isRegistered, Is valid operator: $isValidOperator for SIM: $simName")

                    isRegistered && isValidOperator
                }

                if (filteredCells.isEmpty()) {
                    Log.d("SignalStrength", "No registered cells found for SIM: $simName")
                    return null
                }

                val finalSignalStrength = filteredCells.mapNotNull { cellInfo ->
                    when (cellInfo) {
                        is CellInfoLte -> cellInfo.cellSignalStrength.dbm
                        is CellInfoWcdma -> cellInfo.cellSignalStrength.dbm
                        is CellInfoGsm -> cellInfo.cellSignalStrength.dbm
                        else -> null
                    }
                }.firstOrNull()

                Log.d("SignalStrength", "Final Signal Strength for SIM $simName: $finalSignalStrength dBm")
                return finalSignalStrength
            } else {
                Log.d("SignalStrength", "No cell info available for SIM: $simName")
            }
        }
        Log.d("SignalStrength", "SIM info is null or signal strength could not be determined for SIM: $simName")
        return null
    }


    private fun getActiveSimForData(): String {
        val subscriptionInfoList = subscriptionManager?.activeSubscriptionInfoList ?: return "No active SIM"

        // Get the default data subscription ID
        val defaultDataSubscriptionId = SubscriptionManager.getDefaultDataSubscriptionId()

        for (info in subscriptionInfoList) {
            // Check if the current subscription ID matches the default data subscription ID
            if (info.subscriptionId == defaultDataSubscriptionId) {
                return info.displayName?.toString() ?: "Unknown SIM"
            }
        }
        return "No active Data SIM"
    }

    private fun getSimDetails(): Map<String, Map<String, String?>> {
        val simDetails = mutableMapOf<String, Map<String, String?>>()

        if (ContextCompat.checkSelfPermission(context!!, Manifest.permission.READ_PHONE_STATE) == PackageManager.PERMISSION_GRANTED) {
            val subscriptionInfoList = subscriptionManager?.activeSubscriptionInfoList ?: emptyList()

            subscriptionInfoList.forEach { info ->
                val simSlotIndex = info.simSlotIndex // Get the SIM slot index
                val simIndex = "SIM${simSlotIndex + 1}" // Create SIM1, SIM2 based on slot index

                // Create the details map for this SIM
                val simDetailMap = mapOf(
                        "CarrierName" to info.carrierName?.toString(),
                        "DisplayName" to info.displayName?.toString(),
                        "PhoneNumber" to info.number,
                        "NetworkType" to getNetworkTypeForSim(simSlotIndex) // Use the slot index to get the network type
                )

                // Store the details in the map, ensuring no overwrites for the same slot index
                simDetails[simIndex] = simDetailMap
            }
        }
        return simDetails
    }

    private fun getNetworkTypeForSim(simSlotIndex: Int): String {
        val networkType = telephonyManager?.networkType ?: TelephonyManager.NETWORK_TYPE_UNKNOWN
        return when (networkType) {
            TelephonyManager.NETWORK_TYPE_GPRS, TelephonyManager.NETWORK_TYPE_EDGE, TelephonyManager.NETWORK_TYPE_CDMA, TelephonyManager.NETWORK_TYPE_1xRTT, TelephonyManager.NETWORK_TYPE_IDEN -> "2G"
            TelephonyManager.NETWORK_TYPE_UMTS, TelephonyManager.NETWORK_TYPE_EVDO_0, TelephonyManager.NETWORK_TYPE_EVDO_A, TelephonyManager.NETWORK_TYPE_HSDPA, TelephonyManager.NETWORK_TYPE_HSUPA, TelephonyManager.NETWORK_TYPE_HSPA, TelephonyManager.NETWORK_TYPE_EVDO_B, TelephonyManager.NETWORK_TYPE_EHRPD, TelephonyManager.NETWORK_TYPE_HSPAP -> "3G"
            TelephonyManager.NETWORK_TYPE_LTE, TelephonyManager.NETWORK_TYPE_IWLAN -> "4G LTE"
            TelephonyManager.NETWORK_TYPE_NR -> "5G"
            else -> "Unknown ($networkType)"
        }
    }
}
