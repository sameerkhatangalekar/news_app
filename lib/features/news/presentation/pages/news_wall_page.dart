import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/constants/enums.dart';
import 'package:news_app/core/theme/theme.dart';
import 'package:news_app/features/news/presentation/provider/news_provider.dart';
import 'package:news_app/features/news/presentation/widgets/articles_list.dart';
import 'package:news_app/features/news/presentation/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';

class NewsWallPage extends StatefulWidget {
  const NewsWallPage({super.key});

  @override
  State<NewsWallPage> createState() => _NewsWallPageState();
}

class _NewsWallPageState extends State<NewsWallPage> {
  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MyNews',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          const Icon(
            CupertinoIcons.location_fill,
            color: Colors.white,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            newsProvider.countryCode.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: Colors.white),
          ),
          const SizedBox(
            width: 8,
          )
        ],
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              if (!Scaffold.of(context).isDrawerOpen) {
                Scaffold.of(context).openDrawer();
              }
            },
            icon: const Icon(
              Icons.menu,
            ),
          );
        }),
      ),
      drawer: const CustomDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18, top: 24),
            child: Text(
              'Top Headlines',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
              child: RefreshIndicator(
                color: AppPalette.primaryColor,
            backgroundColor: Colors.white,
            onRefresh: () async {
              await newsProvider.getTopNewsArticles(
                  countryCode: newsProvider.countryCode);
            },
            child: newsProvider.status == NewsStatus.loading
                ? const Center(child: CircularProgressIndicator(color: Colors.black,strokeWidth: 1,))
                : newsProvider.status == NewsStatus.success
                    ? newsProvider.articles.isEmpty
                        ? Center(
                            child: Text(
                              'No articles available',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          )
                        : ArticlesList(articles: newsProvider.articles)
                    : buildTryAgainButton(newsProvider),
          ))
        ],
      ),
    );
  }

  Center buildTryAgainButton(NewsProvider newsProvider) {
    return Center(
      child: TextButton.icon(
          onPressed: () {
            newsProvider.getTopNewsArticles(
                countryCode: newsProvider.countryCode);
          },
          icon: const Icon(Icons.refresh),
          label: Text(
            newsProvider.error ?? 'something went wrong!',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.black),
          )),
    );
  }
}
