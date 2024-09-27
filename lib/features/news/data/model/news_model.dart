
import 'package:news_app/features/news/data/model/article_model.dart';
import 'package:news_app/features/news/domain/entity/article_entity.dart';
import 'package:news_app/features/news/domain/entity/news_entity.dart';

final class NewsModel extends NewsEntity {
  NewsModel(
      {required super.status,
      required super.totalResults,
      required super.articles});

  NewsModel copyWith({
    String? status,
    int? totalResults,
    List<ArticleEntity>? articles,
  }) =>
      NewsModel(
        status: status ?? this.status,
        totalResults: totalResults ?? this.totalResults,
        articles: articles ?? this.articles,
      );

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<ArticleModel>.from(
          json["articles"].map(
            (x) => ArticleModel.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": articles,
      };
}



