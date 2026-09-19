import 'package:bloc/bloc.dart';
import 'package:news_app/modules/home/repository/repository_interface.dart';
import 'package:news_app/modules/home/sources_cubit/sources_states.dart';

class SourcesCubit extends Cubit<SourcesStates> {

  final RepositoryInterface _repositoryInterface;
  SourcesCubit({required this._repositoryInterface}) : super(LoadingGetAllSources());

  /// [GetAllSources] Business Logic for [Sources]

  Future<void> getAllSources(String categoryID) async {
    try {

      /// Call Repository
      final data = await _repositoryInterface.getSources(categoryID);
      emit(SuccessGetAllSources(data));
    } catch (error) {
      emit(ErrorGetAllSources(error.toString()));
    }
  }
}