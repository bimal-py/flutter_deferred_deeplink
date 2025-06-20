import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_deferred_deeplink/flutter_deferred_deeplink.dart';
import 'package:flutter_deferred_deeplink/flutter_deferred_deeplink_platform_interface.dart';
import 'package:flutter_deferred_deeplink/flutter_deferred_deeplink_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterDeferredDeeplinkPlatform
    with MockPlatformInterfaceMixin
    implements FlutterDeferredDeeplinkPlatform {
  @override
  Future<String?> getDeferredDeepLink() => Future.value('42');
}

void main() {
  final FlutterDeferredDeeplinkPlatform initialPlatform =
      FlutterDeferredDeeplinkPlatform.instance;

  test('$MethodChannelFlutterDeferredDeeplink is the default instance', () {
    expect(
      initialPlatform,
      isInstanceOf<MethodChannelFlutterDeferredDeeplink>(),
    );
  });

  test('getPlatformVersion', () async {
    FlutterDeferredDeeplink flutterDeferredDeeplinkPlugin =
        FlutterDeferredDeeplink();
    MockFlutterDeferredDeeplinkPlatform fakePlatform =
        MockFlutterDeferredDeeplinkPlatform();
    FlutterDeferredDeeplinkPlatform.instance = fakePlatform;

    expect(await flutterDeferredDeeplinkPlugin.getDeferredDeepLink(), '42');
  });
}
