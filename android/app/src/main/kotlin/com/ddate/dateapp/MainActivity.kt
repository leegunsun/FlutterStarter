package com.ddate.dateapp

import android.content.Intent
import android.net.Uri
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.util.Log

class MainActivity: FlutterFragmentActivity(){
    private val CHANNEL = "deep_link_channel"
    private lateinit var openActivityLauncher : ActivityResultLauncher<Intent>

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        openActivityLauncher = registerForActivityResult(
            ActivityResultContracts.StartActivityForResult()
        ) { result ->
            if (result.resultCode == RESULT_OK) {
                val returned = result.data?.getStringExtra("result")
                MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
                    .invokeMethod("onActivityResult", returned)
            }
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "getInitialLink" -> {
                        val data = intent?.data?.toString()
                        result.success(data)
                    }
                    "openActivity" -> {
                        val message = call.argument<String>("message")
                        val intent = Intent(this, MyNativeActivity::class.java)
                        intent.putExtra("message", message)
                        openActivityLauncher.launch(intent)
                        result.success("activity_started") // 여기서만 응답
                    }
                    "logToLogcat" -> {
                        val msg = call.argument<String>("message") ?: "null"
                        Log.d("FlutterLogcat", msg)
                        result.success(null)
                    }
                    else -> result.notImplemented()
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
