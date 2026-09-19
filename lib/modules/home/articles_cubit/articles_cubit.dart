import 'package:bloc/bloc.dart';
import 'package:news_app/modules/home/repository/repository_interface.dart';

import 'articles_states.dart';

class ArticlesCubit extends Cubit<ArticlesStates> {

  final RepositoryInterface _repositoryInterface;
  ArticlesCubit({required this._repositoryInterface}) : super(LoadingGetAllArticles());

  Future<void> getAllArticles(String sourceId) async {
    emit(LoadingGetAllArticles());

    try {
      final data = await _repositoryInterface.getArticles(sourceId);
      emit(SuccessGetAllArticles(data));
    } catch (error) {
      emit(ErrorGetAllArticles(error.toString()));
    }
  }
}