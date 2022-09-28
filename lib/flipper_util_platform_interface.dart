import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flipper_util_method_channel.dart';

abstract class FlipperUtilPlatform extends PlatformInterface {
  /// Constructs a FlipperUtilPlatform.
  FlipperUtilPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlipperUtilPlatform _instance = MethodChannelFlipperUtil();

  /// The default instance of [FlipperUtilPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlipperUtil].
  static FlipperUtilPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlipperUtilPlatform] when
  /// they register themselves.
  static set instance(FlipperUtilPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
