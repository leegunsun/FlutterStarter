import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    controller.fetchBlogSearchResults(() => setState(() {}), (value) {
      _connectionState = value;
    });
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
      body: Stack(
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
          ListView.builder(

            shrinkWrap: true,
            itemCount: controller.responses.length,
            itemBuilder: (context, index) {
              final VertextSearchDto? response = controller.responses[index];

              if(response == null) {
                return SizedBox.shrink();
              }

              final List<CrawlContent?> _crawlContent = response.crawlContent.where((CrawlContent? ele) => ele?.contentType == ContentType.image).toList();

              return Stack(
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
                          color: Colors.white
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
                          Padding(
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

                          const SizedBox(height: 15,),

                          ConstrainedBox(
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

                          if(response.recommend != null) ...[
                            const SizedBox(height: 15,),
                            Padding(
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

                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                response.recommend ?? "추천 없음",
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
              );
            },
          ),
        ],
      ),
    );
  }
}
