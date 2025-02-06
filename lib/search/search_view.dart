import 'package:dateapp/customwidget/custom_appbar.dart';
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

class _SearchViewState extends State<SearchView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  final TextStyle _textStyle = TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          dividerColor : Colors.transparent,
          indicatorColor: Colors.black, // 탭 선택 표시 색상
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 2,
          labelStyle: _textStyle,
          unselectedLabelStyle : _textStyle.copyWith(color: Colors.grey),
          overlayColor: WidgetStatePropertyAll(Colors.transparent),
          tabs: [
            Tab(text: "검색",),
            Tab(text: "AI 추천"),
          ],
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [
            ListView(
              children: [
                TextFormField(controller: widget.controller.textEditingController,)
              ],
            ),
            Center(child: Text("⭐ Favorites Page")),
          ],
        ),
      ),
    );
  }
}
