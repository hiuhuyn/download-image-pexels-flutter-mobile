import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/app/domain/entity/category_entity.dart';
import 'package:wallpaper_app/app/domain/usecases/remote/photo/get_curated_photos_usecase.dart';
import 'package:wallpaper_app/app/domain/usecases/remote/photo/get_photos_category.dart';
import 'package:wallpaper_app/app/presentation/pages/home/bloc/home_state.dart';
import 'package:wallpaper_app/core/state/data_state.dart';

class HomeBloc extends Cubit<HomeState> {
  GetPhotosCategoryUsecase getCategorys;
  GetCuratedPhotosUsecase getCuratedPhotos;
  HomeBloc({required this.getCategorys, required this.getCuratedPhotos})
      : super(HomeLoadingState());

  void loadFirst(List<CategoryEntity> titles) async {
    emit(HomeLoadingState());
    try {
      final resultCategory = await getCategorys.call(titles: titles);
      if (resultCategory is DataSuccess) {
        emit(HomeSuccessState(resultCategory.data!));
      } else {
        emit(HomeErrorState(resultCategory.error!));
      }
    } catch (e) {
      emit(HomeErrorState(DioException(
          requestOptions: RequestOptions(), message: e.toString())));
    }
  }
}
