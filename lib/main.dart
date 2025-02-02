import 'dart:convert';

import 'package:dateapp/service/api/naver/dto/crawl_naver_blog.dart';
import 'package:dateapp/service/api/naver/dto/search_dto.dart';
import 'package:dateapp/service/api/naver/naver_api.dart';
import 'package:dateapp/service/api/vertex/dto/vertext_search_dto.dart';
import 'package:dateapp/service/env_service.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:flutter/material.dart' hide Element;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html/dom.dart' show Document, Element;
import 'package:html/parser.dart' as htmlParser;

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EnvService.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _data = "";
  final List<VertextSearchDto?> responses = [];

  final model = FirebaseVertexAI.instance.generativeModel(
      model: 'gemini-1.5-flash',
      generationConfig: GenerationConfig(
          responseMimeType: 'application/json',
          responseSchema: Schema.object(
            description:
                "이 스키마는 데이트 장소를 원하는 연인들에게 적합한 블로그 글을 생성하는 데 사용됩니다. 각 필드는 AI가 글을 구성할 때 의도를 정확히 반영할 수 있도록 정의되었습니다.",
            properties: {
              'title': Schema.string(
                  description: "글의 제목을 나타냅니다. 핵심 주제를 간결하게 표현하는 것이 중요합니다."),
              'blogMobileLink': Schema.string(),
              'postdate': Schema.string(),
              'location': Schema.string(
                  description:
                      "글에서 설명하는 장소의 위치를 나타냅니다. 특정한 장소를 언급하는 경우, 지역명이나 주소 형식으로 작성될 수 있습니다."),
              'recommend': Schema.string(
                  description:
                      "이 글이 어떤 독자에게 유용한 정보를 제공하는지 나타냅니다. 예를 들어, 음식점 리뷰라면 \"맛집을 찾는 사람\" 혹은 \"현지 음식을 경험하고 싶은 여행객\" 등이 될 수 있습니다."),
              'desc': Schema.string(
                  description:
                      "글의 주요 내용을 설명하는 부분입니다. 답변을 격식있는 말투로 작성하지 마세요. 글쓴이의 말투를 유지해야합니다. 글의 흐름을 자연스럽게 이어가며 본문의 내용을 포함해야 합니다."),
            },
            optionalProperties: [
              'title',
              'blogMobileLink',
              'postdate',
              'location',
              'recommend',
              'desc'
            ],
          )));

  Future<CrawlNaverBlog?> crawlNaverBlogMobile({String? url}) async {
    final mobileUrl = url;

    try {
      if (mobileUrl == null) {
        throw Exception("url is null");
      }

      // Step 1: 네이버 블로그 모바일 페이지 요청
      final response = await Dio(
        BaseOptions(
          headers: {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)',
          },
        ),
      ).get(mobileUrl);

      if (response.statusCode == 200) {
        // Step 2: HTML 파싱
        Document document = htmlParser.parse(response.data);

        // Step 3: 본문 내용 추출
        Element? contentElement = document.querySelector('.se-main-container');
        List<String?> imageUrlList = [];

        if (contentElement != null) {
          // 본문 텍스트 정제
          String cleanedText = contentElement.text
              .replaceAll(RegExp(r'\s+'), ' ') // 연속된 공백을 하나로 변경
              .replaceAll(RegExp(r' {2,}'), ' ') // 공백 2개 이상을 하나로 변경
              .trim(); // 앞뒤 공백 제거

          print('본문 추출 완료 (길이: ${cleanedText.length})');

          // Step 4: 모든 이미지 URL 추출
          List<Element> imageElements = contentElement.querySelectorAll('img');

          // 세 번째 이미지 찾기 (인덱스는 2)
          if (imageElements.isNotEmpty) {
            for (Element imageElement in imageElements) {
              imageUrlList.add(imageElement.attributes['src']);
            }
          } else {
            print('본문 내 이미지가 3개 이상 존재하지 않습니다.');
          }

          return CrawlNaverBlog(desc: cleanedText, img: imageUrlList);
        } else {
          print('본문을 찾을 수 없습니다.');
        }
      } else {
        print('페이지 요청 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('오류 발생: $e');
    }
    return null;
  }

  Future<VertextSearchDto?> generateBlogContent(BlogSearchItems item) async {
    final CrawlNaverBlog? _getBlogContent =
        await crawlNaverBlogMobile(url: item.blogMobileLink);

    if (_getBlogContent == null) {
      return null;
    }

    final prompt = [Content.text(_getBlogContent.desc)];

    final GenerateContentResponse response =
        await model.generateContent(prompt);

    Map<String, dynamic>? _encode;
    VertextSearchDto? _result;

    try {
      _encode = jsonDecode(response.text!);

      if (_encode?["desc"] == null) {
        throw Exception("desc is null");
      }

      _result = VertextSearchDto.fromJson(_encode!)
        ..blogMobileLink = item.blogMobileLink!
        ..postdate = item.postdate
        ..img.addAll(_getBlogContent.img)
        ..title ??= item.title;
    } catch (e) {
      print('JSON 디코딩 오류: $e');
      _encode = null;
    }

    return _result;
  }

  Future<void> fetchBlogSearchResults() async {
    _connectionState = ConnectionState.waiting;

    NaverApiBlogSearchDto _result =
        await NaverAPI().blogSearch.getBlogSearch(query: "송파+데이트");

    for (BlogSearchItems item
        in _result.items.where((item) => item.isNaverBlog)) {
      responses.add(await generateBlogContent(item));
      progressValue.value = responses.length / _result.items.length;
    }

    _connectionState = ConnectionState.done;

    setState(() {});
  }

  ConnectionState _connectionState = ConnectionState.none;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchBlogSearchResults();
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

    if(_connectionState != ConnectionState.done) {
      return Scaffold(
        body: ValueListenableBuilder(
          valueListenable: progressValue,
          builder: (context, value, child) {
            return CircularProgressIndicator();
          }
        ),
      );
    }

    return Scaffold(
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: responses.length,
        itemBuilder: (context, index) {
          final VertextSearchDto? response = responses[index];
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (response?.img.isNotEmpty ?? false)
                      Container(
                        clipBehavior: Clip.hardEdge,
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black45),
                        ),
                        child: Image.network(response!.img.first!, fit: BoxFit.cover,),
                      ),
                    Expanded(
                      child: Column(

                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              response?.postdate ?? "날짜 없음",
                            ),
                          ),
                          Text(
                            response?.title ?? "제목 없음",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),



                Text(
                  response?.location ?? "장소 없음",
                ),
                Text(
                  response?.recommend ?? "추천 없음",
                ),
                Text(
                  response?.desc ?? "내용 없음",
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
