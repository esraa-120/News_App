import 'dart:convert';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/source_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CacheService {
  CacheService._();

  static late final SharedPreferences _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static String _sourcesKey(String categoryId) =>
      'sources_$categoryId';

  static String _articlesKey(String sourceId) =>
      'articles_$sourceId';

  static Future<void> savedSources(
      String categoryId,
      List<SourceModel> sources,
      ) async {
    final encodedData = jsonEncode(
      sources.map((source) => source.toJson()).toList(),
    );

    await _preferences.setString(
      _sourcesKey(categoryId),
      encodedData,
    );
  }

  static List<SourceModel>? getSources(String categoryId) {
    final encodedData =
    _preferences.getString(_sourcesKey(categoryId));

    if (encodedData == null) return null;

    final decodedData = jsonDecode(encodedData) as List;

    return decodedData
        .map((source) => SourceModel.fromJson(source))
        .toList();
  }

  static Future<void> saveArticles(
      String sourceId,
      List<ArticleModel> articles,
      ) async {
    final encodedData = jsonEncode(
      articles.map((article) => article.toJson()).toList(),
    );

    await _preferences.setString(
      _articlesKey(sourceId),
      encodedData,
    );
  }

  static List<ArticleModel>? getArticles(String sourceId) {
    final encodedData = _preferences.getString(
      _articlesKey(sourceId),
    );

    if (encodedData == null) {
      return null;
    }

    final decodedData = jsonDecode(encodedData) as List;

    return decodedData
        .map(
          (article) => ArticleModel.fromJson(article),
    )
        .toList();
  }
}