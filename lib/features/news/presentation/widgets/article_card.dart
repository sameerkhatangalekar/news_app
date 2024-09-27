import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/theme/theme.dart';
import 'package:news_app/core/utils/extensions.dart';
import 'package:news_app/core/utils/random_color_generator.dart';
import 'package:news_app/features/news/domain/entity/article_entity.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({
    super.key,
    required this.article,
  });

  final ArticleEntity article;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppPalette.tertiary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.source.name,
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.clip,
                ),
                Text(
                  article.content ?? '-',
                  maxLines: 3,
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  article.publishedAt.timeAgo(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppPalette.backgroundColor,
                        fontStyle: FontStyle.italic
                      ),
                  textAlign: TextAlign.justify,
                )
              ],
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              width: 108,
              height: 108,
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
        ],
      ),
    );
  }
}
