import 'package:api_netflix/api/debouncer.dart';
import 'package:api_netflix/core/color/color.dart';
import 'package:api_netflix/core/constants.dart';
import 'package:api_netflix/presentation/search/screens/search_idie.dart';
import 'package:api_netflix/presentation/search/screens/search_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool changer = false;
  final searchController = TextEditingController();
  final _debouncer = Debouncer(delay: const Duration(microseconds: 500));
  final ValueNotifier<bool> showSearchResult = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CupertinoSearchTextField(
            // ignore: deprecated_member_use
            backgroundColor: Colors.grey.withOpacity(0.3),
            prefixIcon: const Icon(
              CupertinoIcons.search,
              color: avatarGray,
            ),
            suffixIcon: const Icon(
              CupertinoIcons.xmark_circle_fill,
              color: avatarGray,
            ),
            style: TextStyle(color: white),
            onChanged: (value) {
              _debouncer.call(() {
                setState(() {
                  changer = value.isNotEmpty;
                  searchController.text = value;
                });
              });
            },
            onSuffixTap: () {
              searchController.clear();
              setState(() {
                changer = false;
              });
            },
          ),
          hight,
          Expanded(
              child: changer
                  ? SearchResultWidget(
                      result: searchController.text,
                    )
                  : const SearchIdieWidget())
        ],
      ),
    ));
  }
}
