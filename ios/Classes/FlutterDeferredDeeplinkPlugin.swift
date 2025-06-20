import Flutter
import UIKit

public class FlutterDeferredDeeplinkPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_deferred_deeplink", binaryMessenger: registrar.messenger())
    let instance = FlutterDeferredDeeplinkPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "getDeferredLink" {
        if let referrer = UIPasteboard.general.string {
            result(referrer)
        } else {
            result(nil)
        }
    } else {
        result(FlutterMethodNotImplemented)
    }
  }
}
