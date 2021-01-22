package com.example.sailebot_app

import android.app.Application
import android.content.Context
import android.content.Intent
import android.net.Uri
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.lang.Exception

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        NativeCallService.configChannel(this.context, flutterEngine)

    }
}

object NativeCallService {

    private lateinit var mContext: Context

    fun configChannel(context: Context, flutterEngine: FlutterEngine) {
        this.mContext = context
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger,"flutter.sailebotv2.nativeCall").setMethodCallHandler {
            call, result ->
            if (call.method == "makePhoneCall") {
                val phone = call.arguments
                if (phone is String && phone.length > 0) {
                    val isSuccess = this.makePhoneCall(phone)
                    if (isSuccess) {
                        result.success(true)
                    }
                    else {
                        result.error("UNAVAILABLE", "Make call failed", null)
                    }
                }
                else {
                    result.notImplemented()
                }
            }
            else {
                result.notImplemented()
            }
        }
    }

    private fun makePhoneCall(phoneNumber: String) : Boolean {
        return try {
            val intent = Intent(Intent.ACTION_DIAL, Uri.parse("tel:$phoneNumber"))
            this.mContext.startActivity(intent)
            true
        }
        catch (e: Exception) {
            false
        }
    }
}

