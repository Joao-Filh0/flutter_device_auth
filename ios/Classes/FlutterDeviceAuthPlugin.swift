import Flutter
import UIKit
import LocalAuthentication

public class FlutterDeviceAuthPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_device_auth", binaryMessenger: registrar.messenger())
    let instance = FlutterDeviceAuthPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
       if call.method == "biometric" {
         // Verifique se há argumentos e obtenha o título
         if let args = call.arguments as? [String: Any],
            let title = args["title"] as? String {
             authenticate(result: result, title: title)
         } else {
             result(FlutterError(code: "INVALID_ARGUMENTS", message: "Title is missing", details: nil))
         }
       } else {
         result(FlutterMethodNotImplemented)
       }
  }

  private func authenticate(result: @escaping FlutterResult, title: String) {
       let context = LAContext()
       var error: NSError?

       if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
         context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: title) {
           success, authenticationError in

           DispatchQueue.main.async {
             if success {
               result("success")
             } else {
               result("fail")
             }
           }
         }
       } else {
         result("notAvailable")
       }
  }}