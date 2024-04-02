import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/app/presentation/pages/search/bloc/search_state.dart';

class SearchBloc extends Cubit<SearchState> {
  SearchBloc() : super(SearchLoadingState());
}
