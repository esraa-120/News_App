import 'package:news_app/models/source_model.dart';

sealed class SourcesStates {}

class LoadingGetAllSources extends SourcesStates {}

/// [Sources List]
class SuccessGetAllSources extends SourcesStates {
  final List<SourceModel> sourcesList;
  SuccessGetAllSources(this.sourcesList);
}

/// [Error Message]
class ErrorGetAllSources extends SourcesStates {
  final String errorMessage;
  ErrorGetAllSources(this.errorMessage);
}
