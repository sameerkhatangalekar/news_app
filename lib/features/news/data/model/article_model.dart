
import 'package:news_app/features/news/data/model/source_model.dart';
import 'package:news_app/features/news/domain/entity/article_entity.dart';
import 'package:news_app/features/news/domain/entity/source_entity.dart';

final class ArticleModel extends ArticleEntity {
  const ArticleModel(
      {required super.source,
        super.author,
        required super.title,
        super.description,
        required super.url,
        super.urlToImage,
        required super.publishedAt,
         super.content
      });

  factory ArticleModel.fromJson(Map<String, dynamic> map) => ArticleModel(
    source: SourceModel.fromJson(map['source']),
    title: map['title'],
    author: map['author'],
    description: map['description'],
    url: map['url'],
    urlToImage: map['urlToImage'],
    publishedAt: DateTime.parse(map['publishedAt']),
    content: map['content'],
  );

  ArticleModel copyWith({
    SourceEntity? source,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    DateTime? publishedAt,
    String? content,
  }) =>
      ArticleModel(
        source: source ?? this.source,
        author: author ?? this.author,
        title: title ?? this.title,
        description: description ?? this.description,
        url: url ?? this.url,
        urlToImage: urlToImage ?? this.urlToImage,
        publishedAt: publishedAt ?? this.publishedAt,
        content: content ?? this.content,
      );


}