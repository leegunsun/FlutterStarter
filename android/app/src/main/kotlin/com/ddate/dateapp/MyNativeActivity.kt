package com.ddate.dateapp

import android.app.Activity
import android.os.Bundle
import android.os.PersistableBundle
import android.widget.Toast

class MyNativeActivity : Activity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val message = intent.getStringExtra("message");

        Toast.makeText(this, "받은 메세지 : $message", Toast.LENGTH_LONG).show()

        val resultIntent = intent
        resultIntent.putExtra("result", "Native에서 보낸 응답")
        setResult(RESULT_OK, resultIntent)
        finish()
    }
}