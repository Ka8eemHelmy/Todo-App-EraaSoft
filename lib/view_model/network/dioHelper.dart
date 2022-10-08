import 'package:dio/dio.dart';
import 'package:todo_app/view_model/network/endPoints.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String endPoint,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    try {
      dio.options.headers = {
        'Authorization' : 'Bearer $token',
      };
      Response response = await dio.get(
        endPoint,
        queryParameters: query,
      );
      return response;
    } catch (error) {
      print('hereeeee $error');
      throw error;
    }
  }

  static Future<Response> postData(
  {
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String? token,
}
      ) async {
    try{
      dio.options.headers = {
        'Authorization' : 'bearer $token',
      };
      Response response = await dio.post(
        endPoint,
        data: data,
        queryParameters: query,
      );
      return response;
    }catch(error){
      throw error;
    }
  }

  static Future<Response> putData(
      {
        required String endPoint,
        Map<String, dynamic>? data,
        Map<String, dynamic>? query,
        String? token,
      }
      ) async {
    try{
      dio.options.headers = {
        'Authorization' : 'bearer $token',
      };
      Response response = await dio.put(
        endPoint,
        data: data,
        queryParameters: query,
      );
      return response;
    }catch(error){
      throw error;
    }
  }

  static Future<Response> deleteData(
      {
        required String endPoint,
        Map<String, dynamic>? data,
        Map<String, dynamic>? query,
        String? token,
      }
      ) async {
    try{
      dio.options.headers = {
        'Authorization' : 'bearer $token',
      };
      Response response = await dio.delete(
        endPoint,
        data: data,
        queryParameters: query,
      );
      return response;
    }catch(error){
      throw error;
    }
  }
}
