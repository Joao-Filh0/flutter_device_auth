package com.example.biometric_app

import android.content.Context
import androidx.biometric.BiometricManager

import android.os.Build

import androidx.biometric.BiometricManager.Authenticators.BIOMETRIC_STRONG
import androidx.biometric.BiometricPrompt

import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterFragmentActivity

enum class AuthStatus {
    cancel,
    turnPin,
    success,
    notAvailable,
    fail,
    exceededAttempts
}

class BiometricHelper {
    companion object {
        fun isBiometricAvailable(context: Context): Boolean {
            if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M) {
                return false
            }
            val biometricManager = BiometricManager.from(context)
            when (biometricManager.canAuthenticate(BIOMETRIC_STRONG)) {

                BiometricManager.BIOMETRIC_SUCCESS -> return true
                BiometricManager.BIOMETRIC_ERROR_NO_HARDWARE -> return false
                BiometricManager.BIOMETRIC_ERROR_HW_UNAVAILABLE -> return false
                BiometricManager.BIOMETRIC_ERROR_NONE_ENROLLED -> return false
            }
            return false
        }

        fun makePromptBiometric(
            title: String?,
            subtitle: String?,
            description: String?,
            negativeButtonText: String?
        ): BiometricPrompt.PromptInfo {
            val info = BiometricPrompt.PromptInfo.Builder()

            title?.let {
                info.setTitle(it)
            }
            subtitle?.let {
                info.setSubtitle(it)
            }
            description?.let {
                info.setDescription(it)

            }

            negativeButtonText?.let {
                info.setNegativeButtonText(it)
            }

            return info.build()


        }

        fun makePromptPin(
            title: String?,
            subtitle: String?,
            description: String?,
        ): BiometricPrompt.PromptInfo {
            val info = BiometricPrompt.PromptInfo.Builder()

            title?.let {
                info.setTitle(it)
            }
            subtitle?.let {
                info.setSubtitle(it)
            }
            description?.let {
                info.setDescription(it)

            }


            info.setConfirmationRequired(true)
                .setAllowedAuthenticators(BiometricManager.Authenticators.DEVICE_CREDENTIAL)

            return info.build()
        }

        fun showPromptAuthentication(
            activity: FlutterFragmentActivity,
            promptInfo: BiometricPrompt.PromptInfo,
            onResult: (AuthStatus) -> Unit
        ) {

            val executor = ContextCompat.getMainExecutor(activity)
            val bio = BiometricPrompt(
                activity,
                executor,
                object : BiometricPrompt.AuthenticationCallback() {
                    override fun onAuthenticationSucceeded(result: BiometricPrompt.AuthenticationResult) {
                        super.onAuthenticationSucceeded(result)
                        onResult(AuthStatus.success)
                    }

                    override fun onAuthenticationError(errorCode: Int, errString: CharSequence) {
                        super.onAuthenticationError(errorCode, errString)
                        println("CODE $errorCode")
                        when (errorCode) {
                            7 -> {
                                onResult(AuthStatus.fail)
                            }

                            9 -> {
                                onResult(AuthStatus.exceededAttempts)
                            }

                            10 -> {
                                onResult(AuthStatus.cancel)
                            }

                            13 -> {
                                onResult(AuthStatus.turnPin)
                            }
                        }
                    }
                })
            bio.authenticate(promptInfo)


        }
    }
}