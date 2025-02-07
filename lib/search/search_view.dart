import 'package:dateapp/search/search_tabview/search_tab_view_0.dart';
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

    // FocusNode의 상태 변경을 감지하여 ValueNotifier를 업데이트
    _focusScope1.addListener(() {
      _isFocused.value = _focusScope1.hasFocus;
    });
  }

  final TextStyle _textStyle = TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20);
  final ValueNotifier<bool> _isFocused = ValueNotifier<bool>(false);
  final FocusNode _focusScope1 = FocusNode();
  final FocusNode _focusScope2 = FocusNode();

  @override
  void dispose() {
    _focusScope1.dispose();
    _focusScope2.dispose();
    _isFocused.dispose();
    _tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FocusScope(
        child: Stack(
          children: [
            NestedScrollView(
              physics: BouncingScrollPhysics(),
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  pinned: true,
                  // forceElevated: true,
                  scrolledUnderElevation: 0,
                  shadowColor: Colors.transparent,
                  // floating: true,
                  // snap: true,
                  elevation: 0,
                  backgroundColor: Colors.white, // 투명도 없는 배경색 지정
                  title: TextFormField(
                    focusNode: _focusScope1,
                    onTap: () {
                    },
                    controller: widget.controller.textEditingController,
                    onTapOutside: (value) {
                      _focusScope1.unfocus();
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    hintText: widget.controller.textEditingController.text
                    ),
                  ),
                  actions: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.star))
                  ],
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _PersistentTabBar(_tabController, _textStyle),
                ),
              ],
              body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: _tabController,
                viewportFraction: 1,
                children: [
                  SearchTabView0(),

                  // ListView(
                  //   shrinkWrap: true,
                  //   padding: const EdgeInsets.all(16.0),
                  //   children: [
                  //
                  //     Text("최근 검색어"),
                  //     ListView()
                  //     // ...List.generate(20,)
                  //
                  //   ],
                  // ),
                  const Center(child: Text("⭐ AI 추천 페이지")),
                ],
              ),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _isFocused,
              builder: (BuildContext context, bool value, Widget? child) {
                return Visibility(
                    visible: value,
                    child: child!);
              },
              child: Container(
                color: Colors.black.withValues(alpha: 0.3),
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      // forceElevated: true,
                      scrolledUnderElevation: 0,
                      shadowColor: Colors.transparent,
                      // floating: true,
                      // snap: true,
                      elevation: 0,
                      backgroundColor: Colors.white, // 투명도 없는 배경색 지정
                      title: TextFormField(
                        focusNode: _focusScope2,
                        onTap: () {},
                        controller: widget.controller.textEditingController,
                        onTapOutside: (value) {
                          _focusScope2.unfocus();
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: widget.controller.textEditingController.text
                        ),
                      ),
                      actions: [
                        IconButton(onPressed: () {}, icon: Icon(Icons.star))
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


class _PersistentTabBar extends SliverPersistentHeaderDelegate {

  final TabController _tabController;
  final TextStyle _textStyle;
  _PersistentTabBar(this._tabController, this._textStyle);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 2, color: Colors.grey)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TabBar(
        controller: _tabController,
        indicatorColor: Colors.black,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        indicatorWeight: 2,
        labelStyle: _textStyle,
        unselectedLabelStyle: _textStyle.copyWith(color: Colors.grey),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        tabs: const [
          Tab(text: "검색"),
          Tab(text: "AI 추천"),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 52;

  @override
  double get minExtent => 52;


  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
