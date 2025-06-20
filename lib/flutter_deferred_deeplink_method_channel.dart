import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_deferred_deeplink_platform_interface.dart';

/// Method channel implementation of [FlutterDeferredDeeplinkPlatform].
class MethodChannelFlutterDeferredDeeplink
    extends FlutterDeferredDeeplinkPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_deferred_deeplink');

  @override
  Future<String?> getDeferredDeepLink() async {
    final link = await methodChannel.invokeMethod<String>('getDeferredLink');
    return link;
  }
}
