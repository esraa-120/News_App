import 'package:news_app/core/network/http_requests_service.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/source_model.dart';
import 'package:news_app/modules/home/repository/repository_interface.dart';

class RemoteRepositoryImp implements RepositoryInterface{

  @override
  Future<List<ArticleModel>> getArticles(String sourceId) async {
       final data = await HttpRequestsService.getAllArticles(sourceId);
       return data;
  }

  @override
  Future<List<SourceModel>> getSources(String categoryId) async {
    final data = await HttpRequestsService.getAllSources(categoryId);
    return data;
  }
}