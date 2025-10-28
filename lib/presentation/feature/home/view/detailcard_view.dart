
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../enum/content_type.dart';
import '../model/blog_crawl_content.dart';
import '../model/crawl_naver_blog_model.dart';
import '../../../common/webview/view/base_webview.dart';
import '../model/vertex_search_model.dart';

class DetailCardWidget extends StatefulWidget {
  final VertexSearchModel vertextSearchDto;
  final List<CrawlContent?> crawlContentList;

  const DetailCardWidget({super.key, required this.vertextSearchDto, required this.crawlContentList});

  @override
  State<DetailCardWidget> createState() => _DetailCardWidgetState();
}

class _DetailCardWidgetState extends State<DetailCardWidget> {

  List<CrawlContent?> _filterImg = [];
  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController();
  List<GlobalKey> _imageKeys = [];
  final List<double> _imageWidths = [];

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    _imageKeys.clear();  // GlobalKey 리스트 정리
    _imageWidths.clear(); // 이미지 너비 리스트 정리
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _filterImg = widget.vertextSearchDto.crawlContent.where((CrawlContent? ele) => ele?.contentType == ContentType.image).toList();
    _imageKeys.clear();
    _imageWidths.clear();
    _imageKeys.addAll(List.generate(_filterImg.length, (index) => GlobalKey()));
  }


  /// 특정 이미지의 크기 측정 후 저장
  void _updateImageWidth(int index) {
    final RenderBox? renderBox = _imageKeys[index].currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      double width = renderBox.size.width;
      if (index < _imageWidths.length) {
        _imageWidths[index] = width;
      } else {
        _imageWidths.add(width);
      }
    }
  }

  /// 다음 이미지로 스크롤 (크기 반영)
  void _scrollToNext(int currentIndex) {
    if (_imageWidths.isEmpty) return;

    int nextIndex = (currentIndex + 1) % _filterImg.length;
    double scrollOffset = _imageWidths
        .take(nextIndex)
        .fold(0, (sum, width) => sum + width + 16);

    _scrollController.animateTo(
      scrollOffset,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  /// 이전 이미지로 스크롤 (크기 반영)
  void _scrollToPrevious(int currentIndex) {
    if (_imageWidths.isEmpty) return;

    // 이전 인덱스 (첫 번째 이미지면 마지막 이미지로 이동)
    int prevIndex = (currentIndex == 0) ? _filterImg.length - 1 : currentIndex - 1;

    // 이전 인덱스까지의 모든 이미지 넓이의 합을 계산
    double scrollOffset = _imageWidths
        .take(prevIndex)
        .fold(0, (sum, width) => sum + width + 16);

    _scrollController.animateTo(
      scrollOffset,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [

          SliverAppBar(
            actions: [
              Icon(CupertinoIcons.share, size: 34, color: Colors.white,),
              const SizedBox(width: 15,),
            ],
          ),

          // SliverAppBar(
          //   expandedHeight: 200,
          //   pinned: true,
          //   flexibleSpace: FlexibleSpaceBar(
          //     background: Image.network(
          //       widget.vertextSearchDto.crawlContent.firstWhere((CrawlContent? ele) => ele?.contentType == ContentType.image)?.contentValue ?? "",
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),

          SliverToBoxAdapter(
            child: const SizedBox(height: 30), // 100px 높이의 여유 공간
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 0,
                    child: Hero(
                      tag: widget.vertextSearchDto.title ?? DateTime.now().toString(),
                      child: Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.yellowAccent,
                          border: Border.all(color: Colors.deepPurpleAccent, width: 3)
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20,),
                  Expanded(child: Text(widget.vertextSearchDto.title ?? "", textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
            sliver: SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                ),
                height: 400,
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        itemCount: _filterImg.length,
                        itemBuilder : (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              if(_pageController.page!.round() == _filterImg.length - 1) {
                                _pageController.animateToPage(0, duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
                              } else {
                                _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.network(
                                  _filterImg[index]!.contentValue,
                                  fit: BoxFit.cover,
                                  key: _imageKeys[index], // 크기 측정용 key 추가
                                  errorBuilder: (context, _, StackTrace? stackTrace,) {
                                    return Image.network("https://blog.kakaocdn.net/dn/zaHVf/btsCUzDyFK6/zLwkbqViX9RYEST5DwRJmK/img.png", fit: BoxFit.cover,);
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                        controller: _pageController,
                      ),
                      // child: ListView.builder(
                      //   controller: _scrollController,
                      //   scrollDirection: Axis.horizontal,
                      //   itemCount: _filterImg.length,
                      //   itemBuilder: (context, index) {
                      //     return LayoutBuilder(
                      //       builder: (context, constraints) {
                      //         WidgetsBinding.instance.addPostFrameCallback((_) {
                      //           _updateImageWidth(index);
                      //         });
                      //
                      //         return GestureDetector(
                      //           onTap: () {
                      //             _scrollToNext(index);
                      //           },
                      //           child: Padding(
                      //             padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      //             child: ClipRRect(
                      //               borderRadius: BorderRadius.circular(5),
                      //               child: Image.network(
                      //                 _filterImg[index]?.contentValue ?? "",
                      //                 fit: BoxFit.cover,
                      //                 key: _imageKeys[index], // 크기 측정용 key 추가
                      //                 errorBuilder: (context, _, StackTrace? stackTrace,) {
                      //                   return Image.network("https://blog.kakaocdn.net/dn/zaHVf/btsCUzDyFK6/zLwkbqViX9RYEST5DwRJmK/img.png", fit: BoxFit.cover,);
                      //                 },
                      //               ),
                      //             ),
                      //           ),
                      //         );
                      //       },
                      //     );
                      //   },
                      // ),
                    ),
                  ],
                ),
              ),
            ),
          ),


          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(CupertinoIcons.heart, size: 34,),
                  const SizedBox(width: 15,),
                  IconButton(onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BaseWebview(url: widget.vertextSearchDto.blogMobileLink ?? ''),
                      ),
                    );
                  }, icon: Icon(CupertinoIcons.link, size: 34))
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            sliver: SliverToBoxAdapter(
              child: Text(widget.vertextSearchDto.desc ?? "", textAlign: TextAlign.center,),
            ),
          ),

          // SliverList(
          //   delegate: SliverChildBuilderDelegate(
          //       childCount: widget.crawlContentList.length,
          //       (context, index) {
          //           if (widget.crawlContentList[index]?.contentType == ContentType.text) {
          //             return Padding(
          //               padding: const EdgeInsets.symmetric(vertical: 8),
          //               child: Text(
          //                 widget.crawlContentList[index]?.contentValue ?? "",
          //                 style: TextStyle(fontSize: 18),
          //                 textAlign: TextAlign.center,
          //               ),
          //             );
          //           } else if (widget.crawlContentList[index]?.contentType == ContentType.image) {
          //             return Padding(
          //               padding: const EdgeInsets.symmetric(vertical: 8),
          //               child: Image.network(
          //                 widget.crawlContentList[index]?.contentValue ?? "",
          //                 width: double.infinity,
          //                 fit: BoxFit.cover,
          //               ),
          //             );
          //           }
          //           return SizedBox.shrink();
          //       }
          //   ),
          // ),
        ],
      ),
    );
  }
}
