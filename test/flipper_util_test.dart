import 'package:flutter_test/flutter_test.dart';
import 'package:flipper_util/flipper_util.dart';
import 'package:flipper_util/flipper_util_platform_interface.dart';
import 'package:flipper_util/flipper_util_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlipperUtilPlatform 
    with MockPlatformInterfaceMixin
    implements FlipperUtilPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlipperUtilPlatform initialPlatform = FlipperUtilPlatform.instance;

  test('$MethodChannelFlipperUtil is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlipperUtil>());
  });

  test('getPlatformVersion', () async {
    FlipperUtil flipperUtilPlugin = FlipperUtil();
    MockFlipperUtilPlatform fakePlatform = MockFlipperUtilPlatform();
    FlipperUtilPlatform.instance = fakePlatform;
  
    expect(await flipperUtilPlugin.getPlatformVersion(), '42');
  });
}
