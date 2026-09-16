import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/core/config/app_constants.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/source_model.dart';
import 'end_points.dart';

class HttpRequestsService {

  static Future<List<SourceModel>> getAllSources(String categoryID)async {

    ///need tool to fetch data from network
    ///use http package

    final Map<String, dynamic> queryParameters = {
      "apiKey": AppConstants.apiKey,
      "category": categoryID,
    };
    final response = await http.get(Uri.https(AppConstants.baseURL, EndPoints.allSources, queryParameters));

    final decodedData = jsonDecode(response.body);

    List<SourceModel> sources = [];

    for(var source in decodedData["sources"]) {
      sources.add(SourceModel.fromJson(source));
    }
    return sources;
  }

  static Future<List<ArticleModel>> getAllArticles(String sourceId) async {
    final Map <String, dynamic> queryParameters = {
      "apiKey": AppConstants.apiKey,
      "sources": sourceId
    };
    final response = await http.get(Uri.https(
        AppConstants.baseURL, EndPoints.allArticles, queryParameters)
    );

    final decodedData = jsonDecode(response.body);

    List<ArticleModel> articles = [];

    for(var article in decodedData["articles"]) {
    final articleModel = ArticleModel.fromJson(article);
    articles.add(articleModel);
  }
    return articles;
  }
}