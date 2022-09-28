
import 'flipper_util_platform_interface.dart';

class FlipperUtil {
  Future<String?> getPlatformVersion() {
    return FlipperUtilPlatform.instance.getPlatformVersion();
  }
}
