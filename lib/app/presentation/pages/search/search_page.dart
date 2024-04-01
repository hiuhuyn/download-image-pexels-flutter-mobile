import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const SizedBox(height: 40),
            Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    )),
                Expanded(
                  child: SearchBar(
                    backgroundColor:
                        const MaterialStatePropertyAll(Colors.black),
                    textStyle: const MaterialStatePropertyAll(
                        TextStyle(color: Colors.white, fontSize: 15)),
                    overlayColor: const MaterialStatePropertyAll(Colors.red),
                    controller: _searchController,
                    hintText: "Search",
                    elevation: const MaterialStatePropertyAll(1),
                    padding: const MaterialStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 0, horizontal: 8)),
                  ),
                ),
                const SizedBox(
                  width: 20,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
