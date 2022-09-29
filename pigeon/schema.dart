
import 'package:pigeon/pigeon.dart';

// Flutter 调用原生代码

@HostApi()
abstract class FlipperDioApi {


  @async
  void reportRequest(String requestId,
  int timeStamp,
  String uri,
  String method,
  Map<String, String> headers,
  String body );

  @async
  void reportResponse(String requestId,
      int timeStamp,
      int statusCode,
      String statusReason,
      Map<String, String> headers,
      String body );

}



