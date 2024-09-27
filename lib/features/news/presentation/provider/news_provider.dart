import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/constants/enums.dart';
import 'package:news_app/features/news/domain/entity/article_entity.dart';
import 'package:news_app/features/news/domain/usecase/fetch_news_usecase.dart';

final class NewsProvider with ChangeNotifier {
  final FetchNewsUsecase _fetchNewsUsecase;
  final FirebaseRemoteConfig _remoteConfig;
  List<ArticleEntity> _articles = [];

  List<ArticleEntity> get articles => _articles;
  NewsStatus _status = NewsStatus.uninitialized;

  String? _error;
  late String _countryCode;

  String? get error => _error;

  String get countryCode => _countryCode;

  NewsProvider({
    required FetchNewsUsecase fetchNewsUsecase,
    required FirebaseRemoteConfig remoteConfig,
  })  : _fetchNewsUsecase = fetchNewsUsecase,
        _remoteConfig = remoteConfig {
    _countryCode = _remoteConfig.getString('countryCode');
    getTopNewsArticles(countryCode: _countryCode);

    _remoteConfig.fetchAndActivate();
    remoteConfig.onConfigUpdated.listen(_onConfigChange);
  }

  NewsStatus get status => _status;

  Future<void> getTopNewsArticles({required String countryCode}) async {
    _status = NewsStatus.loading;
    notifyListeners();

    final result = await _fetchNewsUsecase(countryCode);

    result.fold(
      (l) {
        _status = NewsStatus.failed;
        _error = l.message;
      },
      (r) {
        _status = NewsStatus.success;
        _articles = r.articles;
      },
    );

    notifyListeners();
  }

  _onConfigChange(RemoteConfigUpdate update) async {
    await _remoteConfig.fetchAndActivate();
    _countryCode = _remoteConfig.getString('countryCode');
    getTopNewsArticles(countryCode: _countryCode);
  }
}
