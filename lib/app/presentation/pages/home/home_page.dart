// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/app/domain/usecases/local/get_categorys_local_usecase.dart';
import 'package:wallpaper_app/app/presentation/pages/home/bloc/home_bloc.dart';
import 'package:wallpaper_app/app/presentation/pages/home/bloc/home_state.dart';
import 'package:wallpaper_app/app/presentation/pages/home/component/page_body_home.dart';
import 'package:wallpaper_app/app/presentation/widgets/failed_widget.dart';
import 'package:wallpaper_app/app/presentation/widgets/loading_widget.dart';
import 'package:wallpaper_app/core/routers/routes_name.dart';
import 'package:wallpaper_app/core/state/data_state.dart';
import 'package:wallpaper_app/setup.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    sl<GetCategorysLocalUsecase>().call().then((value) {
      if (value is DataSuccess) {
        context.read<HomeBloc>().loadFirst(value.data!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallpaper App'),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoadingState) return const LoadingWidget();
          if (state is HomeErrorState) {
            return FailedWidget(error: state.error!);
          }
          return PageView.builder(
            itemCount: state.categories?.length,
            itemBuilder: (context, index) {
              return PageBodyHome(category: state.categories![index]);
            },
          );
        },
      ),
      floatingActionButton: ElevatedButton.icon(
        style: const ButtonStyle(
          foregroundColor: MaterialStatePropertyAll(Colors.black),
        ),
        onPressed: () {
          Navigator.pushNamed(context, RoutesName.kSearch);
        },
        icon: const Icon(Icons.search),
        label: const Text("Search"),
      ),
      drawer: const Drawer(),
    );
  }
}
