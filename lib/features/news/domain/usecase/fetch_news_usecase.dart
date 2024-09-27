import 'package:fpdart/fpdart.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/usecase/usecase.dart';
import 'package:news_app/features/news/domain/entity/news_entity.dart';
import 'package:news_app/features/news/domain/repository/news_repository.dart';

final class FetchNewsUsecase implements UseCase<NewsEntity, String> {
  final NewsRepository _newsRepository;

  FetchNewsUsecase({required NewsRepository newsRepository})
      : _newsRepository = newsRepository;

  @override
  Future<Either<Failure, NewsEntity>> call(String param) async {
    return await _newsRepository.getTopNewsArticles(countryCode: param);
  }
}
