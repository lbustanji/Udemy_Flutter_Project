import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(

        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        ));
  }

  static Future<Response>? getData({
    required String url,
        Map<String, dynamic>? query,
    String lang = 'ar',
    String? authorization ,
  }) async {
    dio.options.headers =  {
      'Content-Type':'application/json',
      'lang': lang,
      'Authorization':authorization
    };
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response>? postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic>? data,
    String lang = 'ar',
    String? authorization ,
  }) async {
    dio.options.headers= {
      'Content-Type':'application/json',
      'lang': lang,
    'Authorization':authorization
    };
    Future<Response> ret=dio.post(url, queryParameters: query, data: data);
    ret.catchError((error){
      print(error.toString());
    });
    return ret;
  }

  static Future<Response>? putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic>? data,
    String lang = 'ar',
    String? authorization ,
  }) async {
    dio.options.headers= {
      'Content-Type':'application/json',
      'lang': lang,
      'Authorization':authorization
    };
    Future<Response> ret=dio.put(url, queryParameters: query, data: data);
    ret.catchError((error){
      print(error.toString());
    });
    return ret;
  }
}
