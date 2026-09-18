import 'package:bloc/bloc.dart';
import 'package:news_app/core/network/http_requests_service.dart';

import 'articles_states.dart';

class ArticlesCubit extends Cubit<ArticlesStates> {
  ArticlesCubit() : super(LoadingGetAllArticles());

  Future<void> getAllArticles(String sourceId) async {
    emit(LoadingGetAllArticles());

    try {
      final data = await HttpRequestsService.getAllArticles(sourceId);
      emit(SuccessGetAllArticles(data));
    } catch (error) {
      emit(ErrorGetAllArticles(error.toString()));
    }
  }
}