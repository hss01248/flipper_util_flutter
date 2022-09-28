import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flipper_util/flipper_util_method_channel.dart';

void main() {
  MethodChannelFlipperUtil platform = MethodChannelFlipperUtil();
  const MethodChannel channel = MethodChannel('flipper_util');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
