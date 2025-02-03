import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../customwidget/search_widget.dart';
import '../search/search_view.dart';
import '../service/api/naver/dto/crawl_naver_blog.dart';
import '../service/api/vertex/dto/vertext_search_dto.dart';
import 'detailcard/view_detailcard.dart';
import 'home_controller.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  HomeController controller = HomeController();

  ConnectionState _connectionState = ConnectionState.none;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialization();
    controller.fetchBlogSearchResults(() => setState(() {}), (value) {
      _connectionState = value;
    });
  }

  void initialization() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    // ignore_for_file: avoid_print
    print('ready in 3...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 2...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 1...');
    await Future.delayed(const Duration(seconds: 1));
    print('go!');
    FlutterNativeSplash.remove();
  }

  ValueNotifier<double> progressValue = ValueNotifier(0.0);

  @override
  void dispose() {
    // TODO: implement dispose
    progressValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if(_connectionState == ConnectionState.waiting) {
      return Scaffold(
        body: ValueListenableBuilder(
            valueListenable: progressValue,
            builder: (context, value, child) {
              return Center(child: CircularProgressIndicator());
            }
        ),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchView()),
                );
              },
              child: Container(
                // margin: const EdgeInsets.only(bottom: 30),
                padding: const EdgeInsets.only(top: 0,bottom: 30, left: 20, right: 20),
                color: Colors.deepPurple, // 부모 컨테이너
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.tealAccent, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.5),
                        blurRadius: 10,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: [
                      Text("검색해 보세요.", style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w600),),
                      Spacer(),
                      Icon(Icons.search, color: Colors.black, size: 30,)
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Stack(
              children: [
                Positioned(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                    ),
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 500, // 최소 높이 설정
                    maxHeight: 610, // 최대 높이 설정
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    // physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.responses.length,
                    itemBuilder: (context, index) {
                      final VertextSearchDto? response = controller.responses[index];

                      if(response == null) {
                        return SizedBox.shrink();
                      }

                      final List<CrawlContent?> _crawlContent = response.crawlContent.where((CrawlContent? ele) => ele?.contentType == ContentType.image).toList();

                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailCardWidget(vertextSearchDto : response, crawlContentList: response.crawlContent,)));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  // border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(24),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.3),
                                        offset: Offset(0, 4),
                                        blurRadius: 5,
                                      )
                                    ]
                                ),
                                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                                padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Align(
                                    //   alignment: Alignment.centerRight,
                                    //   child: Text(
                                    //     response?.postdate ?? "날짜 없음",
                                    //   ),
                                    // ),
                                    const SizedBox(height: 20,),
                                    Flexible(
                                      flex: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Container(
                                          color: Colors.yellowAccent,
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            heightFactor: 0.3,
                                            child: Text(
                                              response.title ?? "제목 없음",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 15,),

                                    Flexible(
                                      flex: 4,
                                      child: ConstrainedBox(
                                        constraints: BoxConstraints(
                                          maxHeight: 200,
                                          maxWidth: MediaQuery.of(context).size.width, // 부모 컨테이너의 너비 설정
                                        ),
                                        child: LayoutBuilder(
                                          builder: (context, constraints) {
                                            double parentWidth = constraints.maxWidth;
                                      
                                            return CustomScrollView(
                                              scrollDirection: Axis.horizontal,
                                              slivers: [
                                                SliverList(
                                                  delegate: SliverChildBuilderDelegate(
                                                        (context, index) {
                                                      final String imgUrl = _crawlContent[index]?.contentValue ?? "";
                                                      return Padding(
                                                        padding: index + 1 == _crawlContent.length ? EdgeInsets.zero : const EdgeInsets.only(right: 10), // 이미지 사이 간격 추가
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(10),
                                                          child: Image.network(
                                                            imgUrl,
                                                            fit: BoxFit.cover,
                                                            width: parentWidth, // 부모 컨테이너의 너비만큼 설정
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    childCount: _crawlContent.length,
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ),

                                    if(response.recommend != null) ...[
                                      const SizedBox(height: 15,),
                                      Flexible(
                                        flex : 0,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                                          child: Row(
                                            children: [
                                              Icon(CupertinoIcons.hand_thumbsup_fill, color: Colors.greenAccent),
                                              Text(
                                                " 추천하고 싶은 사람",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      Flexible(
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            response.recommend ?? "추천 없음",
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 15,)
                                    ],


                                    Container(
                                      height: 50,
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(8),
                                      // margin: const EdgeInsets.symmetric(vertical: 15.0),
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount: response.tag.length ?? 0,
                                        itemBuilder: (context, index) {
                                          return Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                              child: Text(
                                                  "#${response.tag[index]}",
                                                  style: TextStyle(
                                                    color: Colors.grey[600],)
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Icon(Icons.location_on, color: Colors.grey[400],),
                                          Flexible(
                                            child: Text(
                                              response.location ?? "장소 없음",
                                              style: TextStyle(
                                                color: Colors.grey[500],
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Text(
                                    //   response?.desc ?? "내용 없음",
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                            Hero(
                              tag: response.title ?? DateTime.now().toString(),
                              child: Container(
                                height: 50,
                                child: Center(
                                  child: Icon(Icons.location_on_outlined, size: 30, color: Colors.black54,),
                                ),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.tealAccent
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
