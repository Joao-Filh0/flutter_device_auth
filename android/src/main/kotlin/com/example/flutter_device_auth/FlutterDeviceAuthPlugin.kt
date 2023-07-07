package com.example.flutter_device_auth

import android.app.Activity
import androidx.annotation.NonNull
import androidx.fragment.app.FragmentActivity
import com.example.biometric_app.AuthStatus
import com.example.biometric_app.BiometricHelper
import io.flutter.embedding.android.FlutterFragmentActivity

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FlutterDeviceAuthPlugin */
class FlutterDeviceAuthPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {

    private lateinit var channel: MethodChannel
    private lateinit var activity: Activity

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_device_auth")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "biometric") {

            val isAvailable = BiometricHelper.isBiometricAvailable(activity)

            if (isAvailable) {
                val title = call.argument<String>("title")
                val subTitle = call.argument<String>("subTitle")
                val description = call.argument<String>("description")
                val negativeButtonText = call.argument<String>("buttonText")
                val info = BiometricHelper.makePromptBiometric(
                    title,
                    subTitle,
                    description,
                    negativeButtonText,
                )
                BiometricHelper.showPromptAuthentication(
                    activity as FlutterFragmentActivity,
                    info
                ) { args ->
                    result.success(args.name)
                }


            } else {
                result.success(AuthStatus.notAvailable.name)
            }
        } else if (call.method == "pin") {

            val title = call.argument<String>("title")
            val subTitle = call.argument<String>("subTitle")
            val description = call.argument<String>("description")
            val info = BiometricHelper.makePromptPin(
                title,
                subTitle,
                description,
            )
            BiometricHelper.showPromptAuthentication(
                activity as FlutterFragmentActivity,
                info
            ) { args ->
                result.success(args.name)
            }

        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        TODO("Not yet implemented")
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        TODO("Not yet implemented")
    }

    override fun onDetachedFromActivity() {
        TODO("Not yet implemented")
    }
}
