// ignore_for_file: must_be_immutable

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:wallpaper_app/app/domain/entity/category_entity.dart';

class HomeState extends Equatable {
  List<CategoryEntity>? categories;
  DioException? error;

  HomeState({this.categories, this.error});

  HomeState copyWith({
    List<CategoryEntity>? categories,
    DioException? error,
  }) {
    return HomeState(
      categories: categories ?? this.categories,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [error, categories];
}

class HomeSuccessState extends HomeState {
  HomeSuccessState(List<CategoryEntity>? categorys)
      : super(categories: categorys);
}

class HomeErrorState extends HomeState {
  HomeErrorState(DioException error) : super(error: error);
}

class HomeLoadingState extends HomeState {
  HomeLoadingState();
}
