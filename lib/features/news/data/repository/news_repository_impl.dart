import 'package:fpdart/fpdart.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/error/server_exception.dart';
import 'package:news_app/features/news/data/datasources/news_remote_datasource.dart';
import 'package:news_app/features/news/domain/entity/news_entity.dart';
import 'package:news_app/features/news/domain/repository/news_repository.dart';

final class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDatasource _newsRemoteDatasource;

  NewsRepositoryImpl({
    required NewsRemoteDatasource newsRemoteDatasource,
  }) : _newsRemoteDatasource = newsRemoteDatasource;

  @override
  Future<Either<Failure, NewsEntity>> getTopNewsArticles({required String countryCode}) async {
    try {
      final result = await _newsRemoteDatasource.getTopNewsArticles(countryCode: countryCode);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }
}
