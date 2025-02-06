import 'package:flutter/material.dart';

import '../abs/abs_tc.dart';

class SearchView<T extends BaseTextController> extends StatefulWidget {
  final T controller;
  const SearchView({
    super.key,
    required this.controller,
  });

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          TextFormField(
            controller: widget.controller.textEditingController,
          ),
          Container(
            child: Text("data"),
          )
        ],
      ),
    );
  }
}
