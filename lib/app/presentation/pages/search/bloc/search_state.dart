// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import 'package:wallpaper_app/app/domain/entity/category_entity.dart';
import 'package:wallpaper_app/app/domain/entity/collection_entity.dart';

class SearchState extends Equatable {
  List<CategoryEntity>? collections;
  List<CollectionEntity>? trendings;
  int page;

  DioException? error;
  SearchState({this.trendings, this.collections, this.error, this.page = 1});

  @override
  List<Object?> get props => [trendings, collections, error];

  SearchState copyWith({
    List<CategoryEntity>? collections,
    List<CollectionEntity>? trendings,
    int? page,
    DioException? error,
  }) {
    return SearchState(
      collections: collections ?? this.collections,
      trendings: trendings ?? this.trendings,
      page: page ?? this.page,
      error: error ?? this.error,
    );
  }
}

class SearchSuccessState extends SearchState {
  SearchSuccessState(
      {required List<CollectionEntity> trendings,
      required List<CategoryEntity> collections,
      int page = 1})
      : super(trendings: trendings, collections: collections, page: page);
}

class SearchErrorState extends SearchState {
  SearchErrorState({
    required DioException error,
    List<CollectionEntity>? trendings,
    List<CategoryEntity>? collections,
  }) : super(error: error, collections: collections, trendings: trendings);
}

class SearchLoadingState extends SearchState {
  SearchLoadingState({SearchState? state})
      : super(collections: state?.collections, trendings: state?.trendings);
}
