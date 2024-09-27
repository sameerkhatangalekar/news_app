import 'package:dio/dio.dart';
import 'package:news_app/core/constants/urls.dart';
import 'package:news_app/core/error/server_exception.dart';
import 'package:news_app/core/secret/secrets.dart';
import 'package:news_app/core/utils/dio_error_processor.dart';
import 'package:news_app/features/news/data/model/news_model.dart';

abstract interface class NewsRemoteDatasource {
  Future<NewsModel> getTopNewsArticles({required String countryCode});
}

final class NewsRemoteDatasourceImpl implements NewsRemoteDatasource {
  final Dio _dio;

  NewsRemoteDatasourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<NewsModel> getTopNewsArticles({required String countryCode}) async {
    try {
      final response = await _dio.get(
          '${NewsApi.baseUrl}/top-headlines?country=$countryCode&apiKey=$newsApiKey');
      return NewsModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(message: dioErrorProcessor(e));
    }
  }
}
