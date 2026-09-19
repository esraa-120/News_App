import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/source_model.dart';
import 'package:news_app/modules/home/repository/repository_interface.dart';

class LocalRepositoryImp implements RepositoryInterface {

  @override
  Future<List<ArticleModel>> getArticles(String sourceId) async {
    // final data = await HttpRequestsService.getAllArticles(sourceId);
    // return data;
    throw UnimplementedError();
  }

  @override
  Future<List<SourceModel>> getSources(String categoryId) async {
    // final data = await HttpRequestsService.getAllSources(categoryId);
    // return data;
    throw UnimplementedError();
  }
}
