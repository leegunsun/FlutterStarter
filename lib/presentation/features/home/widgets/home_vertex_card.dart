import 'dart:isolate';

import 'package:dateapp/app/di/modules/conbin_provider.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../presentation/feature/home/model/crawl_naver_blog_model.dart';
import '../../../../presentation/feature/home/model/vertex_search_model.dart';
import '../../../../presentation/feature/home/view/detailcard_view.dart';
import '../../../../presentation/feature/home/enum/content_type.dart';

import '../../../../core/theme/custom_theme_color.dart';

class VertexCarousel extends ConsumerWidget {

  const VertexCarousel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final AsyncValue<List<VertexSearchModel>> provider = ref.watch(combinedProvider);

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 500, // 최소 높이 설정
        maxHeight: 610, // 최대 높이 설정
      ),
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.9),
        scrollDirection: Axis.horizontal,
        // physics: NeverScrollableScrollPhysics(),
        itemCount: provider.value?.length,
        itemBuilder: (context, index) {
          final VertexSearchModel? response = provider.value?[index];
          if(response == null) {
            return SizedBox.shrink();
          }

          final List<CrawlContent?> _crawlContent = response.crawlContent
              .where((CrawlContent? ele) => ele?.contentType == ContentType.image)
              .toList();

          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                GestureDetector(
                  onTap: () async {

                    try {
                      await FirebaseAnalytics.instance.logEvent(name: 'click_test',parameters: {"event_name" : "true"});
                    } catch (e) {
                      print(e);
                    }

                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailCardWidget(vertextSearchDto : response, crawlContentList: response.crawlContent,)));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      // border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(24),
                        color: CustomThemeColor.cardBackground,
                        boxShadow: CustomThemeColor.cardBoxShadow
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

                                return PageView.builder(
                                  controller: PageController(viewportFraction: 0.8),
                                    itemCount: _crawlContent.length,
                                    itemBuilder: (BuildContext context, int index) {

                                  final String imgUrl = _crawlContent[index]?.contentValue ?? "";

                                    return Padding(
                                      padding: index + 1 == _crawlContent.length ? EdgeInsets.zero : const EdgeInsets.only(right: 10), // 이미지 사이 간격 추가
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                          child: Image.network(
                                            imgUrl,
                                            fit: BoxFit.cover,
                                            width: parentWidth,
                                            // loadingBuilder: (context, child, loadingProgress) {
                                            //   if (loadingProgress == null) {
                                            //     // 로딩 완료 = 캐시에서 즉시 로드됨
                                            //     print('✓ 이미지 즉시 표시 (캐시됨): ${imgUrl.substring(0, 50)}');
                                            //     return child;
                                            //   }
                                            //
                                            //   // 이 부분이 실행되면 네트워크에서 다운로드 중
                                            //   final progress = loadingProgress.expectedTotalBytes != null
                                            //       ? loadingProgress.cumulativeBytesLoaded /
                                            //       loadingProgress.expectedTotalBytes!
                                            //       : null;
                                            //
                                            //   print('⏳ 네트워크 다운로드 중: $progress');
                                            //
                                            //   return Center(
                                            //     child: CircularProgressIndicator(value: progress),
                                            //   );
                                            // },
                                          )
                                      ),
                                    );
                                });
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

                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: CustomThemeColor.cardRecommendBackground,
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
                            itemCount: response.tag.length,
                            itemBuilder: (context, index) {
                              return Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Text(
                                      "#${response.tag[index]}",
                                      style: TextStyle(
                                        color: CustomThemeColor.cardSecondFont,)
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
                              Icon(Icons.location_on, color: CustomThemeColor.cardThirdFont,),
                              Flexible(
                                child: Text(
                                  response.location ?? "장소 없음",
                                  style: TextStyle(
                                    color: CustomThemeColor.cardThirdFont,
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
                      child: Icon(response.category.icon, size: 30, color: CustomThemeColor.icon,),
                    ),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: CustomThemeColor.point
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}