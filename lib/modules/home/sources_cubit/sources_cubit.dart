import 'package:bloc/bloc.dart';
import 'package:news_app/core/network/http_requests_service.dart';
import 'package:news_app/modules/home/sources_cubit/sources_states.dart';

class SourcesCubit extends Cubit<SourcesStates> {
  SourcesCubit() : super(LoadingGetAllSources());

  /// [GetAllSources] Business Logic for [Sources]

  Future<void> getAllSources(String categoryID) async {
    try {
      final data = await HttpRequestsService.getAllSources(categoryID);
      emit(SuccessGetAllSources(data));
    } catch (error) {
      emit(ErrorGetAllSources(error.toString()));
    }
  }
}