package com.cklamib.flutter_deferred_deeplink


import android.content.Context
import com.android.installreferrer.api.InstallReferrerClient
import com.android.installreferrer.api.InstallReferrerStateListener
import com.android.installreferrer.api.ReferrerDetails
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class FlutterDeferredDeeplinkPlugin : FlutterPlugin, MethodChannel.MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext
        channel = MethodChannel(binding.binaryMessenger, "flutter_deferred_deeplink")
        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    if (call.method == "getDeferredLink") {
        val referrerClient = InstallReferrerClient.newBuilder(context).build()
        referrerClient.startConnection(object : InstallReferrerStateListener {
            override fun onInstallReferrerSetupFinished(responseCode: Int) {
                when (responseCode) {
                    InstallReferrerClient.InstallReferrerResponse.OK -> {
                        try {
                            val response: ReferrerDetails = referrerClient.installReferrer
                            val referrer = response.installReferrer
                            result.success(referrer)
                        } catch (e: Exception) {
                            result.error("ERROR", "Exception while fetching referrer", e.localizedMessage)
                        } finally {
                            referrerClient.endConnection()
                        }
                    }
                    else -> result.success(null)
                }
            }

            override fun onInstallReferrerServiceDisconnected() {
                // Try reconnecting in a real app, for now just return null
                result.success(null)
            }
        })
    } else {
        result.notImplemented()
    }
}

}