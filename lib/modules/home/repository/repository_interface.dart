import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/source_model.dart';

abstract class RepositoryInterface {

  Future<List<SourceModel>> getSources(String categoryId);
  Future<List<ArticleModel>> getArticles(String sourceId);
}