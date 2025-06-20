import 'flutter_deferred_deeplink_platform_interface.dart';

class FlutterDeferredDeeplink {
  /// Public API to get deferred deep link.
  Future<String?> getDeferredDeepLink() {
    return FlutterDeferredDeeplinkPlatform.instance.getDeferredDeepLink();
  }
}
