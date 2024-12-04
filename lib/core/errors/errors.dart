import 'package:dio/dio.dart';

abstract class Errors {
  final String errMessage;

  Errors(this.errMessage);
}

class ServerError extends Errors {
  ServerError(super.errMessage);

  factory ServerError.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerError("connection timeout with server");
      case DioExceptionType.sendTimeout:
        return ServerError("Send timeout with server");
      case DioExceptionType.receiveTimeout:
        return ServerError("Receive timeout with server");
      case DioExceptionType.badCertificate:
        return ServerError("Bad certificate with server");
      case DioExceptionType.badResponse:
        ServerError.fromResponse(
            dioError.response!.statusCode!, dioError.response!.data);
      case DioExceptionType.cancel:
        return ServerError("Request Cancelled");
      case DioExceptionType.connectionError:
        return ServerError("Connection Error");

      case DioExceptionType.unknown:
        if (dioError.message!.contains("SocketException")) {
          return ServerError("No Internet connection");
        } else {
          return ServerError("Unknown Error, please try again");
        }
    }
    return ServerError("Unhandled DioExceptionType: ${dioError.type}");
  }

  factory ServerError.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerError(response["error"]["message"]);
    } else if (statusCode == 404) {
      return ServerError("Resource not found");
    } else if (statusCode == 500) {
      return ServerError("Internal Server Error");
    } else {
      return ServerError("Unknown Error");
    }
  }
}
