


class RequestInfo {
  String? requestId;
  int? timeStamp;
  Map<String, String>? headers;
  String? method;
  String? uri;
  String? body;

  RequestInfo({
    this.requestId,
    this.timeStamp,
    this.headers,
    this.method,
    this.uri,
    this.body,
  });

  Map<String, dynamic> toJson() {
    if (headers == null) {
      headers = new Map();
    }
    return {
      'requestId' : requestId,
      'timeStamp' : timeStamp,
      'headers'   : headers,
      'method'    : method,
      'uri'       : uri,
      'body'      : body,
    };
  }
}

class ResponseInfo {
  String? requestId;
  int? timeStamp;
  int? statusCode;
  String? statusReason;
  Map<String, String>? headers;
  String? body;

  ResponseInfo({
    this.requestId,
    this.timeStamp,
    this.statusCode,
    this.statusReason,
    this.headers,
    this.body,
  });
  Map<String, dynamic> toJson() {
    if (headers == null) {
      headers = new Map();
    }
    return {
      'requestId'     : requestId,
      'timeStamp'     : timeStamp,
      'statusCode'    : statusCode,
      'statusReason'  : statusReason,
      'headers'       : headers,
      'body'          : body,
    };
  }
}