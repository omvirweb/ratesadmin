package com.example.jewelbook_rates_admin

import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

//flutter clean
//flutter pub get
//flutter build apk

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.jewelbook_rates_admin/android_id"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getAndroidId") {
                val androidId = getAndroidId()
                result.success(androidId)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getAndroidId(): String {
        return Settings.Secure.getString(contentResolver, Settings.Secure.ANDROID_ID)
    }
}
