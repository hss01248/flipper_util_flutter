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



![image-20220929143528503](https://cdn.jsdelivr.net/gh/shuiniuhss/myimages@main/imagemac2/1664433328558-image-20220929143528503.jpg)
