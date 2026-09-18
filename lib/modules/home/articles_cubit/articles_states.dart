import 'package:news_app/models/article_model.dart';

sealed class ArticlesStates {}

class LoadingGetAllArticles extends ArticlesStates {}

class SuccessGetAllArticles extends ArticlesStates {
  final List<ArticleModel> articlesList;
  SuccessGetAllArticles(this.articlesList);
}

class ErrorGetAllArticles extends ArticlesStates {
  final String errorMessage;
  ErrorGetAllArticles(this.errorMessage);
}
