import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_deferred_deeplink_method_channel.dart';

abstract class FlutterDeferredDeeplinkPlatform extends PlatformInterface {
  FlutterDeferredDeeplinkPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterDeferredDeeplinkPlatform _instance =
      MethodChannelFlutterDeferredDeeplink();

  static FlutterDeferredDeeplinkPlatform get instance => _instance;

  static set instance(FlutterDeferredDeeplinkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Platform-specific implementation to fetch the deferred deep link.
  Future<String?> getDeferredDeepLink() {
    throw UnimplementedError('getDeferredDeepLink() has not been implemented.');
  }
}
