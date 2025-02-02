import 'package:dateapp/service/api/naver/naver_api.dart';
import 'package:dateapp/service/env_service.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart' hide Element;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html/dom.dart' show Document,Element;
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


  Future<void> crawlNaverBlogMobile() async {
    final mobileUrl = "https://m.blog.naver.com/ninamath/223714352718";

    try {
      // Step 1: 네이버 블로그 모바일 페이지 요청
      final response = await Dio(
        BaseOptions(
          headers: {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)', // 봇 차단 우회
          },
        ),
      ).get(mobileUrl);

      if (response.statusCode == 200) {
        // Step 2: HTML 파싱
        Document document = htmlParser.parse(response.data);

        // Step 3: 본문 내용 추출
        Element? contentElement = document.querySelector('.se-main-container');

        if (contentElement != null) {
          String cleanedText = contentElement.text
              .replaceAll(RegExp(r'\s+'), ' ') // 연속된 공백 하나로 변경
              .replaceAll(RegExp(r' {2,}'), ' ') // 공백 2개 이상을 하나로 변경
              .trim(); // 앞뒤 공백 제거

          setState(() {
            _data = cleanedText;
          });

          print('본문 내용: $cleanedText');
          print('본문 추출 완료 (길이: ${cleanedText.length})');
        } else {
          print('본문을 찾을 수 없습니다.');
        }
      } else {
        print('페이지 요청 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('오류 발생: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(onPressed: () async {
             var _result = await NaverAPI().blogSearch.getBlogSearch(query: "test");
             // await crawlNaverBlogMobile();
             print("");
            }, child: Text("data")),
            Text(_data)
          ],
        ),
      ),
    );
  }
}
