# flipper_util

flutter plugin for [flipperUtil](https://github.com/hss01248/flipperUtil)

* Dio interceptor : report http info to flipper client  in android

## Getting Started



## dio interceptor

```dart
 Dio dio = Dio();
//add the FlipperKitDioInterceptor as the last interceptor
dio.interceptors.add(FlipperKitDioInterceptor(topRouter: (){
  //return the top router name ,it will display in request headers
    return "page/topTest";
  }))
```

* show top router in request header  as " flutter-top-router"
* show reqeust cookie in response header as "cookies_from_request"

![image-20220929143528503](https://cdn.jsdelivr.net/gh/shuiniuhss/myimages@main/imagemac2/1664433328558-image-20220929143528503.jpg)

 # attention

if use with [dio_http_formatter](https://pub.dev/packages/dio_http_formatter), you should override it's methods:

```dart
///1 HttpFormatter 无法处理只有httpcode,body为空字符串的情况
class MyHttpFormatter extends HttpFormatter{

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    ///2 在super里直接重新new了一个extra,脑子抽了吧,会导致其他拦截器在extra里放的数据丢失
    options.extra.putIfAbsent("start_time", () => DateTime.now().millisecondsSinceEpoch);
    handler.next(options);
    //super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.data != null) {
     if(response.data == "" || response.data == " "){
       response.data = '{"fakeResponseToAvoidDioCrash":1}';
     }
    }
    super.onResponse(response, handler);
  }

}

class MyChuckerInterceprot extends ChuckerDioInterceptor{

  @override
  Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async{
    try{
      ///只有await才能catch住,return future无法catch
      await super.onResponse(response, handler);
    }catch (e){
      debugPrint(e.toString());
      handler.next(response);
    }
  }

}
```

