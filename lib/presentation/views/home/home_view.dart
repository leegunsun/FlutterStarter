import 'package:dateapp/presentation/widgets/home_naver_card.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_search.dart';
import '../../widgets/custom_title.dart';
import '../../widgets/home_vertext_card.dart';

import '../../viewmodel/home_view_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  HomeViewModel controller = HomeViewModel();

  ConnectionState _connectionState = ConnectionState.none;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialization();
    controller.fetchBlogSearchResults(() {
      if(mounted) {
        setState(() {});
      }
    }, (value) {
      _connectionState = value;
    });
  }

  void initialization() async {

    await controller.remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10), // 원격 데이터 가져오기 제한 시간
        minimumFetchInterval: const Duration(minutes: 1), // 최소 업데이트 간격
      ),
    );

    await controller.remoteConfig.setDefaults(const <String, dynamic>{
      "home_sub_title": "👋 좋아요 ",
      "close_server": "false",
    });

    await controller.remoteConfig.fetchAndActivate();
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
      return PopScope(
        canPop: false, // 뒤로 가기 버튼을 무력화
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop) {
            // 뒤로 가기 버튼이 눌렸을 때 수행할 동작
            print("뒤로 가기 버튼이 눌렸지만 앱이 종료되지 않음");
          }
        },
        child: Scaffold(
          body: ValueListenableBuilder(
            valueListenable: progressValue,
            builder: (context, value, child) {
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      );
    }

    return PopScope(
      canPop: false, // 뒤로 가기 버튼이 무력화됨
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          // 뒤로 가기 버튼이 눌렸을 때 원하는 동작 수행 가능
          print("뒤로 가기 버튼이 눌렸지만 앱이 종료되지 않음");
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(controller: controller),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: CustomSearchBar(controller: controller),
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
                      VertexCarousel(controller: controller),
                    ],
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: const SizedBox(height: 40),
            ),
            SliverToBoxAdapter(
              child: CustomTitle.bottom(
                title: controller.remoteConfig.getString("home_sub_title"),
              ),
            ),
            SliverListNaverCard(controller: controller),
          ],
        ),
      ),
    );
  }
}