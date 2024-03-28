import 'package:dio/dio.dart';

abstract class DataState<T> {
  final T? data;
  final DioException? error;
  final int? progress;

  const DataState({this.data, this.error, this.progress});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(DioException error) : super(error: error);
}

class DataLoading<T> extends DataState<T> {
  const DataLoading(int progress) : super(progress: progress);
}