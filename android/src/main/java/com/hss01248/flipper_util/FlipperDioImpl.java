package com.hss01248.flipper_util;

import android.util.Log;

import java.util.Map;

/**
 * @Despciption todo
 * @Author hss
 * @Date 28/09/2022 10:59
 * @Version 1.0
 */
public class FlipperDioImpl implements FlipperPigeon.FlipperDioApi{
    @Override
    public void reportRequest(String requestId, Long timeStamp, String uri, String method, Map<String, String> headers, String body, FlipperPigeon.Result<Void> result) {
        //com.hss01248.flipper.http.FlutterDioApi.reportRequest();
        try {
            Class clazz =  Class.forName("com.hss01248.flipper.http.FlutterDioApi");
            clazz.getMethod("reportRequest",String.class,Long.class,String.class,String.class,Map.class,String.class)
                    .invoke(clazz,requestId,timeStamp,uri,method,headers,body);
        }catch (Throwable throwable){
            //throwable.printStackTrace();
            Log.v("flipperdio","com.hss01248.flipper.http.FlutterDioApi not found");
        }

    }

    @Override
    public void reportResponse(String requestId, Long timeStamp, Long statusCode, String statusReason, Map<String, String> headers, String body, FlipperPigeon.Result<Void> result) {
        //com.hss01248.flipper.http.FlutterDioApi.reportResponse();
        try {
            Class clazz =  Class.forName("com.hss01248.flipper.http.FlutterDioApi");
            clazz.getMethod("reportResponse",String.class,Long.class,Long.class,String.class,Map.class,String.class)
                    .invoke(clazz,requestId,timeStamp,statusCode,statusReason,headers,body);
        }catch (Throwable throwable){
            //throwable.printStackTrace();
            Log.v("flipperdio","com.hss01248.flipper.http.FlutterDioApi not found");
        }
    }
}
