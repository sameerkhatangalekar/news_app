import 'package:fpdart/fpdart.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/features/news/domain/entity/news_entity.dart';

abstract interface class NewsRepository {
  Future<Either<Failure, NewsEntity>> getTopNewsArticles({required String countryCode});


}
