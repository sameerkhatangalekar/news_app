



import 'article_entity.dart';

abstract class NewsEntity  {
  final String status;
  final int totalResults;
  final List<ArticleEntity> articles;

  const NewsEntity(
      {required this.status,
      required this.totalResults,
      required this.articles});
}




