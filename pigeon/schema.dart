import 'package:flipper_util/param_info.dart';
import 'package:pigeon/pigeon.dart';

// Flutter 调用原生代码

@HostApi()
abstract class FlipperDioApi {


  @async
  void reportRequest(RequestInfo info );

  @async
  void reportResponse(ResponseInfo info );

}



