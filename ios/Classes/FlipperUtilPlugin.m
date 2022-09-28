#import "FlipperUtilPlugin.h"
#if __has_include(<flipper_util/flipper_util-Swift.h>)
#import <flipper_util/flipper_util-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flipper_util-Swift.h"
#endif

@implementation FlipperUtilPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlipperUtilPlugin registerWithRegistrar:registrar];
}
@end
