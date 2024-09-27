import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:news_app/features/news/domain/entity/article_entity.dart';
import 'package:news_app/features/news/presentation/widgets/article_card.dart';

class ArticlesList extends StatelessWidget {
  final List<ArticleEntity> articles;

  const ArticlesList({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
       constraints:  const BoxConstraints(
            maxWidth: 840
        ),
        child: GridView.builder(
          scrollDirection: Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
          itemCount: articles.length,
          itemBuilder: (_, index) {
            final article = articles[index];
            return GestureDetector(
              onTap: () {
                context.push('/article', extra: article);
              },
              child: ArticleCard(article: article),
            );
          },
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              mainAxisExtent: 140,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              maxCrossAxisExtent: 400),
        ),
      ),
    );
  }
}
