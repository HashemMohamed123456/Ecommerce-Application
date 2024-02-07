import 'package:dio/dio.dart';
import 'package:ecommerce_eraasoft/view_model/data/network/DioHelper/endpoints.dart';
class DioHelper{
  static late Dio dio;
  static void init(){
    dio=Dio(
      BaseOptions(
        baseUrl:Endpoints.baseUrl,
        receiveDataWhenStatusError: true
      )
    );
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
