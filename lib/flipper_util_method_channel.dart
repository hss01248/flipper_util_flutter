import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flipper_util_platform_interface.dart';

/// An implementation of [FlipperUtilPlatform] that uses method channels.
class MethodChannelFlipperUtil extends FlipperUtilPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flipper_util');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
