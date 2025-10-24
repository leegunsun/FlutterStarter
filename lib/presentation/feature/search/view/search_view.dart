import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/config/environment_config.dart';
import '../../../../core/local_database/source/local_secure_source.dart';
import '../../../../core/widgets/feature/search/NewWidget.dart';
import '../notifiers/search_blog.dart';
import '../notifiers/search_common.dart';
import 'search_tab_view_0.dart';

class SearchView extends ConsumerStatefulWidget {

  const SearchView({
    super.key,
    // required this.controller,
  });

  @override
  ConsumerState<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends ConsumerState<SearchView> with SingleTickerProviderStateMixin {


  late TabController _tabController;
  late final List<FocusNode> _focusScope;


  final TextStyle _textStyle = TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20);
  final ValueNotifier<bool> isFocused = ValueNotifier<bool>(false);
  final List<String> _getSearchHistory = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadSearchHistory();
    _focusScope = List.generate(2, (e) => FocusNode());
    
    _tabController = TabController(length: 2, vsync: this);
    // FocusNode의 상태 변경을 감지하여 ValueNotifier를 업데이트
    _focusScope[0].addListener(() {
      isFocused.value = _focusScope[0].hasFocus;
    });
  }


  Future<void> loadSearchHistory () async {

   List<dynamic> itemList = await LocalSecureSource
        .get
        .getSecureItem(EnvironmentConfig.constants.SEARCH_HISTORY);

   _getSearchHistory.addAll(itemList.take(40)
       .whereType<String>()
       .where((e) => e.isNotEmpty));


    if(mounted) {
      setState(() {});
    }
  }

  void setSearchHistory (String? controllerAsync) {

    if(controllerAsync == null || controllerAsync.isEmpty) {
      return;
    }

    _getSearchHistory.add(controllerAsync);
    LocalSecureSource.set.searchInputHistory(value: _getSearchHistory);
  }


  @override
  void dispose() {

    for (FocusNode scope in _focusScope) {
      scope.dispose();
    }
    isFocused.dispose();
    _tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final TextEditingController controllerAsync = ref.watch(queryTextControllerProvider).value ?? TextEditingController();

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
                  scrolledUnderElevation: 0,
                  shadowColor: Colors.transparent,
                  elevation: 0,
                  backgroundColor: Colors.white,
                  title: NewWidget(focusScope: _focusScope[0], textEditingController: controllerAsync),
                  actions: [
                    IconButton(onPressed: () async {
                      ref.read(blogSearchProvider.notifier).refresh();

                      setSearchHistory(controllerAsync.value?.text);
                    }, icon: Icon(Icons.star))
                  ],
                ),
                SliverPersistentHeader(
                  floating: true,
                  delegate: _PersistentTabBar(_tabController, _textStyle),
                ),
              ],
              body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: _tabController,
                viewportFraction: 1,
                children: [
                  SearchTabView0(getSearchHistory: _getSearchHistory,),

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
              valueListenable: isFocused,
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
                      title: NewWidget(focusScope: _focusScope[1], textEditingController: controllerAsync,),
                      actions: [
                        IconButton(onPressed: () {
                        }, icon: Icon(Icons.star))
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

