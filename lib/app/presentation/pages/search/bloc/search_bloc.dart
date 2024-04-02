import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/app/domain/entity/category_entity.dart';
import 'package:wallpaper_app/app/domain/usecases/remote/get_collections_usecase.dart';
import 'package:wallpaper_app/app/domain/usecases/remote/photo/get_photos_category.dart';
import 'package:wallpaper_app/app/presentation/pages/search/bloc/search_state.dart';
import 'package:wallpaper_app/core/state/data_state.dart';

class SearchBloc extends Cubit<SearchState> {
  GetCollectionsUsecase getCollectionsUsecase;
  GetPhotosCategoryUsecase getPhotosCategoryUsecase;

  SearchBloc(this.getCollectionsUsecase, this.getPhotosCategoryUsecase)
      : super(SearchLoadingState());
  void loadFirst({List<CategoryEntity>? listCategory}) async {
    emit(SearchLoadingState());
    try {
      if (listCategory != null) {
        await _loadCollections(listCategory);
        await _loadTrending(1);
      } else {
        await _loadTrending(1);
      }
      await _loadTrending(1);
    } catch (e) {
      emit(SearchErrorState(
          error: DioException(
              requestOptions: RequestOptions(), message: e.toString())));
    }
  }

  Future _loadCollections(List<CategoryEntity> titles) async {
    final response = await getPhotosCategoryUsecase.call(titles: titles);
    if (response is DataSuccess) {
      emit(SearchSuccessState(
          collections: response.data!,
          trendings: state.trendings ?? [],
          page: state.page));
    } else {
      SearchErrorState newError =
          SearchErrorState(error: response.error!, trendings: state.trendings);
      emit(newError);
    }
  }

  Future _loadTrending(int page) async {
    final response = await getCollectionsUsecase.call(
        page: page, perPage: 80, getImageFirst: false);
    if (response is DataSuccess) {
      emit(SearchSuccessState(
          collections: state.collections ?? [],
          trendings: response.data!,
          page: page));
    } else {
      SearchErrorState newError = SearchErrorState(
          error: response.error!, collections: state.collections);
      emit(newError);
    }
  }
}
