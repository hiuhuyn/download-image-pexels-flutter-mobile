// ignore_for_file: must_be_immutable

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:wallpaper_app/app/domain/entity/category_entity.dart';

class SearchState extends Equatable {
  List<CategoryEntity>? trendings;
  List<CategoryEntity>? collections;
  DioException? error;
  SearchState({this.trendings, this.collections, this.error});

  @override
  List<Object?> get props => [trendings, collections, error];
}

class SearchSuccessState extends SearchState {
  SearchSuccessState(
      {required List<CategoryEntity> trendings,
      required List<CategoryEntity> collections})
      : super(trendings: trendings, collections: collections);
}

class SearchErrorState extends SearchState {
  SearchErrorState({required DioException error}) : super(error: error);
}

class SearchLoadingState extends SearchState {
  SearchLoadingState({SearchState? state})
      : super(collections: state?.collections, trendings: state?.trendings);
}
