import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flutter_web/network/api_util.dart';


@RestApi()
abstract class AIApi {
  factory AIApi (Dio dio) = _AIApi;
  @POST(ApiUtil.salient_seg)
  Future<String?> salient_seg(@Body() String imageBase64);

  @POST(ApiUtil.text2img)
  Future<String?> text2image(@Body() String imageBase64, String positive_prompt, String negtive_prompt);
}

class _AIApi implements AIApi{
  _AIApi(this._dio){
    ArgumentError.checkNotNull(_dio, '_dio');
  }
  final Dio _dio;

  @override
  salient_seg(imageBase64) async{
    ArgumentError.checkNotNull(imageBase64, 'imageBase64');
    final data = {"image": imageBase64};
    final Response<Map<String, dynamic>> _result = await _dio.post(
      ApiUtil.salient_seg,
      data: data
    );

    if (_result==null) return null;
    return _result.data!['result'];}
  
  @override
  text2image(imageBase64, positive_prompt, negtive_prompt) async{
    ArgumentError.checkNotNull(imageBase64, 'imageBase64');
    final data = {"image": imageBase64, "positive_prompt":positive_prompt, "negtive_prompt":negtive_prompt};
    final Response<Map<String, dynamic>> _result = await _dio.post(
      ApiUtil.text2img,
      data: data
    );

    if (_result==null) return null;
    return _result.data!['result'];}
  
}