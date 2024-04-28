package com.example.frontend451

import android.content.Context
import android.telephony.TelephonyManager 
import android.telephony.CellInfoLte 
import android.telephony.CellInfoGsm 
import android.telephony.CellInfoWcdma 
import io.flutter.embedding.android.FlutterActivity 
import io.flutter.plugin.common.MethodChannel 
import android.os.Bundle 
import io.flutter.embedding.engine.FlutterEngine 
import android.Manifest 
import android.content.pm.PackageManager 
import androidx.core.app.ActivityCompat 
import androidx.core.content.ContextCompat
import java.text.SimpleDateFormat
import java.util.Locale
import android.net.wifi.WifiManager
import java.net.InetAddress
import java.net.NetworkInterface
import java.util.Collections

class MainActivity: FlutterActivity() { 
    private val CHANNEL = "com.example.cellinfo/cellinfo"
    private val PERMISSIONS_REQUEST_CODE = 123

    private fun requestPermissions() {
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.ACCESS_FINE_LOCATION), PERMISSIONS_REQUEST_CODE)
        }
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.ACCESS_WIFI_STATE) != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.ACCESS_WIFI_STATE), PERMISSIONS_REQUEST_CODE)
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getCellInfo") {
                val cellInfo = getCellInfo(this)
                result.success(cellInfo)
            } else {
                result.notImplemented()
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        requestPermissions()
    }

    fun getCellInfo(context: Context): String {
        val telephonyManager = context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
        val cellInfoList = telephonyManager.allCellInfo
        val dateFormat = SimpleDateFormat("dd MMM yyyy hh:mm a", Locale.getDefault())
        val ipAddress = getIPAddress(context)
        val macAddress = getMACAddress(context)

        var info = ""
        for (cellInfo in cellInfoList) {
            when (cellInfo) {
                is CellInfoLte -> {
                    val cellIdentity = cellInfo.cellIdentity
                    val cellSignalStrength = cellInfo.cellSignalStrength
                    val rsrp = cellSignalStrength.rsrp
                    val rsrq = cellSignalStrength.rsrq
                    val snr = rsrp - (rsrq * 20)
                    info += "SNR: $snr\n"
                    info += "Network Type: LTE\n"
                    info += "Frequency Band: ${cellIdentity.earfcn}\n"
                    info += "Cell ID: ${cellIdentity.ci}\n"
                }
                is CellInfoWcdma -> {
                    val cellIdentity = cellInfo.cellIdentity
                    val cellSignalStrength = cellInfo.cellSignalStrength
                    info += "Network Type: UMTS\n"
                    info += "Frequency Band: ${cellIdentity.uarfcn}\n"
                    info += "Cell ID: ${cellIdentity.cid}\n"
                }
                is CellInfoGsm -> {
                    val cellIdentity = cellInfo.cellIdentity
                    val cellSignalStrength = cellInfo.cellSignalStrength
                    info += "Network Type: GSM\n"
                    info += "Frequency Band: ${cellIdentity.arfcn}\n"
                    info += "Cell ID: ${cellIdentity.cid}\n"
                }
            }
            info += "Operator: ${telephonyManager.networkOperatorName}\n"
            info += "Signal Power: ${cellInfo.cellSignalStrength.dbm}dBm\n"
            info += "Time Stamp: ${dateFormat.format(cellInfo.timeStamp)}\n"
        }
        info += "IP Address: $ipAddress\n"
        info += "MAC Address: $macAddress\n"
        return info
    }

    fun getIPAddress(context: Context): String? {
        val wifiManager = context.applicationContext.getSystemService(WIFI_SERVICE) as WifiManager
        val ipAddress = wifiManager.connectionInfo.ipAddress
        return String.format(
            "%d.%d.%d.%d",
            (ipAddress and 0xff),
            (ipAddress shr 8 and 0xff),
            (ipAddress shr 16 and 0xff),
            (ipAddress shr 24 and 0xff)
        )
    }

    fun getMACAddress(context: Context): String? {
        val wifiManager = context.applicationContext.getSystemService(WIFI_SERVICE) as WifiManager
        val wifiInfo = wifiManager.connectionInfo
        return wifiInfo.macAddress
    }
}