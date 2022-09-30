library flipperkit_dio_interceptor;

import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';
import 'api_generated.dart';

typedef TopRouter = String Function();

class FlipperKitDioInterceptor extends InterceptorsWrapper {
  final _uuid = Uuid();
  final FlipperDioApi _flipperNetworkPlugin = FlipperDioApi();

  TopRouter? topRouter;

  FlipperKitDioInterceptor({this.topRouter});

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    _reportRequest(options);
    handler.next(options);
  }

  @override
  void onResponse(
      Response response,
      ResponseInterceptorHandler handler,
      ) async {
    _reportResponse(response);
    handler.next(response);
  }

  @override
  void onError(
      DioError err,
      ErrorInterceptorHandler handler,
      ) async {
    if (err.response != null) {
      _reportResponse(err.response!);
    }
    handler.next(err);
  }

  void _reportRequest(RequestOptions options) {
    var uniqueId = _uuid.v4();

    //options.extra.putIfAbsent(key, () => uniqueId);
    if(options.extra == null){
      options.extra = {};
    }
    options.extra[key] =  uniqueId;
   // debugPrint("options.extra.toString(): "+options.extra.toString());


    Map<String,String> headers = {};
    //response.headers.map,
    options.headers.forEach((key, value) {
      headers[key] = value.toString();
    });
    String body = buildRequestBodyStr(options,headers);
    //headers["from-flutter"] = "1";
    headers["flutter-top-router"] = topRouter?.call()??"unSetTopRouterFunction";



    try{
      _flipperNetworkPlugin.reportRequest(uniqueId??"",DateTime.now().millisecondsSinceEpoch,
          '${options.baseUrl}${options.path}',options.method,headers,body);
    }catch(e,s){
      debugPrint(e.toString()+"\n"+s.toString());
    }
  }

  static String key = "__uniqueId_flipper__";
  void _reportResponse(Response response) {
    var uniqueId = response.requestOptions.extra[key];
   // debugPrint("response.requestOptions.extra.toString(): "+response.requestOptions.extra.toString());
    //debugPrint("response id:"+ uniqueId.toString());



    Map<String,String> headers = {};
    //response.headers.map,
    response.headers.map.forEach((key, value) {
      if(value == null || value.isEmpty){
        headers[key] = "";
      }else{
        String headerVals = value[0];
        if(value.length> 1){
          int i = 0;
          value.forEach((element) {
            if(i > 0){
              headerVals = headerVals + "\n"+element;
            }
            i++;
          });
        }
        headers[key] = headerVals;
      }
    });
    String body = buildResponseStr(response,headers);
    //处理cookie:
    if(response.requestOptions.headers["cookie"] != null){
      headers["cookies_from_request"] = response.requestOptions.headers["cookie"];
    }

    try{
      //uniqueId 为空问题
      _flipperNetworkPlugin.reportResponse(uniqueId??"",DateTime.now().millisecondsSinceEpoch,
          response.statusCode??-1,response.statusMessage??"unknown",headers,body);
    }catch(e,s){
      debugPrint(e.toString()+"\n"+s.toString());
    }


  }

  String buildRequestBodyStr(RequestOptions options,Map<String,String> headers) {
    String? contentType = contentType2(options.headers);
    if(isStr(contentType)){
      dynamic data =  options.data;
      // debugPrint("response : "+ data.toString());
      if (data == null){
        return "body null";
      }
      if(data is Map){
        return json.encode(data);
      }else if(data is List){
        return json.encode(data);
      }
      return data.toString();
    }
    headers["content-type-real"] = contentType.toString();
    headers["content-type"] = "text/plain";
    return "request body not text-> "+contentType.toString();
  }

  String buildResponseStr(Response<dynamic> response,Map<String,String> headers) {
    String? contentType = contentType2(response.headers.map);
    if(isStr(contentType)){
      dynamic data =  response.data;
     // debugPrint("response : "+ data.toString());
      if (data == null){
        return "response null";
      }
      if(data is Map){
        return json.encode(data);
      }else if(data is List){
        return json.encode(data);
      }
      return data.toString();
    }
    headers["content-type-real"] = contentType.toString().replaceAll("[", "").replaceAll("]", "");
    headers["content-type"] = "text/plain";

    return "not text--> "+ contentType.toString();
  }

  bool isStr(String? type){
    if(type == null){
      return false;
    }
    if(type.contains("text") || type.contains("json") || type.contains("xml")){
      return true;
    }
    return false;
  }

  String?  contentType2(Map<String,dynamic> headers){
    if(headers == null){
      return "";
    }
    String? type = headers["content-type"].toString();
    //List<String>
    if(type == null || type == "null" || type == "[]"){
      type = headers["Content-Type"].toString();
    }
    if(type == null || type == "null" || type == "[]"){
      type = headers["content-Type"].toString();
    }

    //debugPrint("content type: "+ type);
    return type;
  }
}
