import 'package:dio/dio.dart';
import 'package:flutter_web/network/interceptor.dart';

enum RequestProtocolType{
  https,
  http,
}

Dio? dio;

class DioBuilder {
  BaseOptions? options;
  String protocol = "http";
  String baseUrl = "localhost";
  Map<String, dynamic> headers = {};
  int connectTimeout = 6000;

  String proxyHost = "";
  String proxyPort = "";
  List<Interceptor> interceptors = [];
  DioBuilder setProtocol(RequestProtocolType protocolType){
    switch(protocolType){
      case RequestProtocolType.http:
      protocol="http";
      break;
      case RequestProtocolType.https:
      protocol="https";
      break;
      default:
      protocol="http";
    }
    return this;
  }
  DioBuilder setBaseUrl(String baseUrl){
    this.baseUrl = baseUrl;
    return this;
  }

  DioBuilder setHeader(Map<String, dynamic> headers){
    headers.forEach((key, value) {this.headers[key]=value;});
    return this;
  }

  DioBuilder setConnectTimeout(int connectTimeout){
    this.connectTimeout = connectTimeout;
    return this;
  }

  DioBuilder addInterceptor(Interceptor interceptor){
    interceptors.add(interceptor);
    return this;
  }

  DioBuilder addProxy(String proxyHost,String proxyPort){
    this.proxyHost = proxyHost;
    this.proxyPort = proxyPort;
    return this;
  }

  build(){
    options = BaseOptions(
      baseUrl: "$protocol://$baseUrl",
      connectTimeout: Duration(milliseconds:connectTimeout),
      responseType: ResponseType.json,
      receiveTimeout: Duration(milliseconds:connectTimeout),
      headers: headers,
      contentType: Headers.jsonContentType
    );
    dio = Dio(options);
    interceptors.add(BaseInterceptor());
    for(Interceptor element in interceptors){
      dio!.interceptors.add(element);
    }

  }
}