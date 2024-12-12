import 'package:dio/dio.dart';
import 'package:untitled2/core/api_helper/api_constants.dart';

class ApiManager {
  final Dio _dio = Dio();

  ApiManager() {
    _dio.options.baseUrl = ApiConstants.baseUrl;
  }

  Future<Response> post(String endPoint, dynamic data,
      {dynamic headers}) async {
    return await _dio.post(
      endPoint,
      data: data,
      options: Options(headers: headers, ),
    );
  }

  Future<Response> get(String endPoint, {dynamic headers}) async {
    return await _dio.get(endPoint, options: Options(headers: headers));
  }

  Future<Response> delete(String endPoint,
      {dynamic headers, dynamic body}) async {
    return await _dio.delete(endPoint,
        options: Options(headers: headers), data: body);
  }

  Future<Response> patch(String endPoint,
      {dynamic data, dynamic headers}) async {
    return await _dio.patch(
      endPoint,
      data: data,
      options: Options(
        headers: headers,
      ),
    );
  }
}
