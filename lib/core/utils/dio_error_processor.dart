import 'package:dio/dio.dart';

String dioErrorProcessor(DioException error) {
  if (error.response == null) {
    return 'An unexpected server error occurred';
  }

  if (error.response?.data['message'] == null) {
    return 'An unexpected server error occurred';
  }

  if (error.response!.data['message'].runtimeType == String) {
    return error.response!.data['message'];
  }
  return 'An unexpected server error occurred';
}
