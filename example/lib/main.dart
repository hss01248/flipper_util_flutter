import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flipper_util/flipper_util.dart';
import 'package:flipper_util/flipperkit_dio_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());

  MyApp.dio.interceptors.add(FlipperKitDioInterceptor(topRouter: (){
    return "page/topTest";
  }));
}

class MyApp extends StatefulWidget {
  static Dio dio = Dio();

  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _flipperUtilPlugin = FlipperUtil();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _flipperUtilPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Expanded(
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      getHtml();
                    },
                    child: Text('发get请求->html')),
                ElevatedButton(
                    onPressed: () {
                      getImage();
                    },
                    child: Text('发get请求->图片')),
                ElevatedButton(
                    onPressed: () {
                      getImage();
                    },
                    child: Text('发post请求-json')),
                ElevatedButton(
                    onPressed: () {
                      getImage();
                    },
                    child: Text('发put请求-上传图片')),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getHtml() async {
    Map<String, dynamic> headers = {};
    headers["p1"] = 90;
    headers["p2"] = 91;
    Response response = await MyApp.dio.get(
        "https://book.flutterchina.club/chapter11/dio.html#_11-3-1-%E5%BC%95%E5%85%A5dio",
        options: Options(headers: headers));
    //print(response.data.toString());
  }

  Future<void> getImage() async {
    Map<String, dynamic> headers = {};
    headers["p67"] = 90;
    headers["p56"] = 91;
    Response response = await MyApp.dio.get(
        "http://n.sinaimg.cn/front/121/w1441h1080/20180415/BRHA-fzcyxmv0612172.jpg",
        options: Options(headers: headers));
    //print(response.data.toString());
  }
}
