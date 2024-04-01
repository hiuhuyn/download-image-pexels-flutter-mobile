import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wallpaper_app/core/routers/routes_name.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _appbar(),
          ],
        ),
      ),
    );
  }

  Widget _collection() {
    return Column();
  }

  Widget _collectionTrending() {
    return Column();
  }

  Widget _appbar() {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        Expanded(
            child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(RoutesName.kSearchInput);
          },
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Search",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                Icon(Icons.search)
              ],
            ),
          ),
        )),
      ],
    );
  }
}
