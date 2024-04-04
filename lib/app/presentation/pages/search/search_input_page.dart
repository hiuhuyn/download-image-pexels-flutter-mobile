import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/app/presentation/pages/search/component/body_search_input.dart';

// ignore: must_be_immutable
class SearchInputPage extends StatefulWidget {
  String? keyword;
  SearchInputPage({super.key, this.keyword});

  @override
  State<SearchInputPage> createState() => _SearchInputPageState();
}

class _SearchInputPageState extends State<SearchInputPage> {
  late final TextEditingController _textCtrl;
  late final FocusNode _focusNode;
  String input = "";
  @override
  void initState() {
    super.initState();
    _textCtrl = TextEditingController(text: widget.keyword ?? '');
    input = widget.keyword ?? '';
    _focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
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
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                  child: CupertinoSearchTextField(
                    onSubmitted: (value) {
                      print("onsubmitted: $value");
                      setState(() {
                        input = value;
                      });
                    },
                    controller: _textCtrl,
                    focusNode: _focusNode,
                    placeholder: "Search",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  ),
                )),
              ],
            ),
            Expanded(
                child: PageView(
              scrollDirection: Axis.horizontal,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: BodySearchInput(
                    keywork: input,
                    isPhotoPage: true,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: BodySearchInput(
                    keywork: input,
                    isPhotoPage: false,
                  ),
                ),
              ],
            )),
            // Expanded(
            //   child: SizedBox(
            //     width: MediaQuery.of(context).size.width,
            //     height: MediaQuery.of(context).size.height,
            //     child: BodySearchInput(
            //       keywork: _input,
            //       isPhotoPage: true,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
