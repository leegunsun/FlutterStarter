import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:url_launcher/url_launcher.dart';


import '../../../core/models/vertex/vertex_search_model.dart';
import '../../viewmodel/home_view_model.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_search.dart';
import '../../widgets/custom_title.dart';
import '../../widgets/home_naver_card.dart';
import '../../widgets/home_vertext_card.dart';
import '../chat/chat_view.dart';


// 1) ConsumerStatefulWidget으로 변경
class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  late final FirebaseRemoteConfig _remoteConfig;
  ValueNotifier<double> progressValue = ValueNotifier(0.0);

  @override
  void initState() {
    super.initState();
    _remoteConfig = FirebaseRemoteConfig.instance;
    _initRemoteConfig();
    // 만약 강제 초기 로드가 필요하다면 아래 호출
    // ref.read(combinedProvider.notifier).refresh();
  }

  Future<void> _initRemoteConfig() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(minutes: 1),
    ));
    await _remoteConfig.setDefaults(const {
      "home_sub_title": "👋 좋아요 ",
      "close_server": "false",
      "suggest_list": "맛집', '데이트 코스', '음식점 추천",
    });
    await _remoteConfig.fetchAndActivate();
    if(mounted) {
      setState(() {}); // 파라미터 가져온 뒤 UI 업데이트
    }
  }

  @override
  void dispose() {
    progressValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 2) Riverpod에서 제공하는 AsyncValue로 콘텐츠 로딩 상태 구독
    final AsyncValue<List<VertexSearchModel>> aiListAsync = ref.watch(combinedProvider);

    return aiListAsync.when(
      loading: () => PopScope(
        canPop: false,
        child: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (err, st) => Scaffold(
        body: Center(child: Text('오류 발생: $err')),
      ),
      data: (List<VertexSearchModel> aiItems) => PopScope(
        canPop: false,
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            heroTag: 'fab_chat',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ChatScreen()),
              );
            },
            child: const Icon(Icons.chat),
          ),
          appBar: CustomAppBar(
            // 필요에 따라 Riverpod ref.read(...)로 상태 전달
          ),
          body: CustomScrollView(
            slivers: [
              // 4) CustomSearchBar를 StateProvider와 연동
              SliverToBoxAdapter(
                child: CustomSearchBar(
                  // initialText: query,
                  // onChanged: (val) =>
                  // ref.read(queryTextProvider.notifier).state = val,
                  // onSubmitted: (_) =>
                  //     ref.read(combinedProvider.notifier).refresh(),
                ),
              ),
              SliverToBoxAdapter(
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 3,
                      decoration: const BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        const CustomTitle(title: "✨AI 추천 "),
                        // 5) Riverpod으로 받은 aiItems 전달
                        VertexCarousel(),
                      ],
                    ),
                  ],
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 40)),
              SliverToBoxAdapter(
                child: CustomTitle.bottom(
                  title: _remoteConfig.getString('home_sub_title'),
                ),
              ),
              // 6) 블로그 카드도 FutureProvider로 구독
              SliverListNaverCard(

              ),
            ],
          ),
        ),
      ),
    );
  }
}