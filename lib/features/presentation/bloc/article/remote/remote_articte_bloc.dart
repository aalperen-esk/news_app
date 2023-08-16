// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/domain/usercases/get_article.dart';
import 'package:news_app/features/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:news_app/features/presentation/bloc/article/remote/remote_article_state.dart';

class RemoteArticlesBloc extends Bloc<RemoteArticlesEvent, RemoteArticleState> {
  final GetArticleUseCase _getArticleUseCase;
  RemoteArticlesBloc(
    this._getArticleUseCase,
  ) : super(const RemoteArticlesLoading()) {
    on<GetArticles>(onGetArticles);
  }

  void onGetArticles(
      GetArticles event, Emitter<RemoteArticleState> emit) async {
    final dataState = await _getArticleUseCase();
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteArticlesDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      // print(dataState.error!.message);
      emit(RemoteArticleError(dataState.error!));
    }
  }
}
