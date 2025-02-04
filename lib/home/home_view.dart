import 'package:collection/collection.dart';
import 'package:dateapp/customwidget/custom_title.dart';
import 'package:dateapp/customwidget/home_naver_card.dart';
import 'package:dateapp/helper/custom_helper.dart';
import 'package:dateapp/service/webview/base_webview.dart';
import 'package:dateapp/theme/custom_theme_color.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../customwidget/custom_appbar.dart';
import '../customwidget/custom_search.dart';
import '../customwidget/home_vertext_card.dart';
import '../search/search_view.dart';
import '../service/api/naver/dto/crawl_naver_blog.dart';
import '../service/api/naver/dto/search_dto.dart';
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

  final remoteConfig = FirebaseRemoteConfig.instance;

  void initialization() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    // ignore_for_file: avoid_print

    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10), // 원격 데이터 가져오기 제한 시간
        minimumFetchInterval: const Duration(minutes: 1), // 최소 업데이트 간격
      ),
    );

    await remoteConfig.setDefaults(const <String, dynamic>{
      "home_sub_title": "👋 좋아요 ",
    });

    await remoteConfig.fetchAndActivate();

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
    if (_connectionState == ConnectionState.waiting) {
      return Scaffold(
        body: ValueListenableBuilder(
            valueListenable: progressValue,
            builder: (context, value, child) {
              return Center(child: CircularProgressIndicator());
            }),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: CustomSearchBar(),
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
                Column(
                  children: [
                    CustomTitle(title: "✨AI 추천 "),
                    VertexCarousel(
                      controller: controller,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: const SizedBox(height: 40,),
          ),
          SliverToBoxAdapter(
            child: CustomTitle.bottom(title: remoteConfig.getString("home_sub_title")),
          ),
          SliverListNaverCard(controller: controller),
        ],
      ),
    );
  }
}
