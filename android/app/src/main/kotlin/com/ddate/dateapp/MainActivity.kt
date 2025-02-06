package com.ddate.dateapp

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Intent
import android.net.Uri

class MainActivity: FlutterActivity(){
    private val CHANNEL = "deep_link_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getInitialLink") {
                val data = intent?.data?.toString()
                result.success(data)
            } else {
                result.notImplemented()
            }
        }
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)

        val data: Uri? = intent.data
        if (data != null) {
            flutterEngine?.dartExecutor?.let {
                MethodChannel(it.binaryMessenger, CHANNEL)
                        .invokeMethod("onAppLinkReceived", data.toString())
            }
        }
    }
}
