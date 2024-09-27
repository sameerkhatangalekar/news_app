import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/utils/extensions.dart';
import 'package:news_app/core/utils/random_color_generator.dart';
import 'package:news_app/features/news/domain/entity/article_entity.dart';

class ArticlePage extends StatelessWidget {
  final ArticleEntity article;

  const ArticlePage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(
              Icons.arrow_back,
            ),
            style:
                ButtonStyle(padding: WidgetStateProperty.all(EdgeInsets.zero)),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(28),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      width: 360,
                      height: 200,
                      imageUrl: article.urlToImage ?? '',
                      fit: BoxFit.cover,
                      errorWidget: (context, _, __) => Container(
                        color: getRandomColor(),
                        child: const Center(
                          child: Icon(
                            Icons.error_outline,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      placeholder: (ctx, value) {
                        return Container(
                          color: getRandomColor(),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    article.title,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.clip,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Text(
                        article.publishedAt.timeAgo(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade400,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    article.content ?? '-',
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
