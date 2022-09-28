flutter pub run pigeon \
--input pigeon/schema.dart \
--dart_out lib/api_generated.dart \
--objc_header_out /Users/hss/flutter/flipper_util/ios/Runner/Pigeon.h \
--objc_source_out /Users/hss/flutter/flipper_util/ios/Runner/Pigeon.m \
--objc_prefix FLT \
--java_out android/src/main/java/com/hss01248/flipper_util/FlipperPigeon.java \
--java_package "com.hss01248.flipper_util"
