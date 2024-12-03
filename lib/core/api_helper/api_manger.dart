import 'package:dio/dio.dart';
import 'package:untitled2/core/api_helper/api_constants.dart';

class ApiManager {
  final Dio _dio = Dio();

  ApiManager() {
    _dio.options.baseUrl = ApiConstants.baseUrl;
  }

  Future<Response> post(String endPoint, dynamic data) async {
    return await _dio.post(endPoint, data: data);
  }

  Future<Response> get(String endPoint) async {
    return await _dio.get(endPoint);
  }

  Future<Response> delete(String endPoint) async {
    return await _dio.delete(endPoint);
  }

  Future<Response> patch(String endPoint, { required dynamic data,required dynamic headers}) async {
    return await _dio.patch(
      endPoint,
      data: data,
      options: Options(
        headers: headers,
      ),
    );
  }
}
