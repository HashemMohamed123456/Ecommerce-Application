import 'package:dio/dio.dart';
import 'package:ecommerce_eraasoft/view_model/data/network/DioHelper/endpoints.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
class DioHelper{
  static late Dio dio;
  static void init(){
    dio=Dio(
      BaseOptions(
        baseUrl:Endpoints.baseUrl,
        receiveDataWhenStatusError: true
      )
    );
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
  }
static Future<Response>post({
  required String endpoint,
  String? token,
  Map<String,dynamic>?body,
  Map<String,dynamic>?params,
})async{
    dio.options.headers={
      'lang':'en',
      'Content-type':'application/json',
      'Authorization':token??''
    };
return await dio.post(endpoint,data: body,queryParameters: params);
}
  static Future<Response>put({
    required String endpoint,
    String? token,
    Map<String,dynamic>?body,
    Map<String,dynamic>?params,
  })async{
    dio.options.headers={
      'lang':'en',
      'Content-type':'application/json',
      'Authorization':token??''
    };
    return await dio.put(endpoint,data: body,queryParameters: params);
  }
  static Future<Response>get({
    required String endpoint,
    String? token,
    Map<String,dynamic>?params,
  })async{
    dio.options.headers={
      'lang':'en',
      'Content-type':'application/json',
      'Authorization':token??''
    };
    return await dio.get(endpoint,queryParameters: params);
  }
  static Future<Response>delete({
    required String endpoint,
    String? token,
    Map<String,dynamic>?body,
    Map<String,dynamic>?params,
  })async{
    dio.options.headers={
      'lang':'en',
      'Content-type':'application/json',
      'Authorization':token??''
    };
    return await dio.delete(endpoint,data: body,queryParameters: params);
  }

}
