import 'package:dateapp/app/di/modules/conbin_provider.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes/navigation_routes.dart';
import '../../../../core/layout/appbars/custom_appbar.dart';
import '../../../../core/widgets/common/text/custom_title.dart';
import '../../../../core/widgets/feature/home/home_naver_card.dart';
import '../../../../core/widgets/feature/home/home_vertex_card.dart';
import '../../../../core/widgets/feature/search/custom_search.dart';
import '../model/vertex_search_model.dart';


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
    final AsyncValue<List<VertexSearchModel>> aiListAsync = ref.watch(combinedProvider);

    // 뒤로가기 제어를 위해 PopScope 또는 WillPopScope를 상위에 둔다.
    return PopScope(
      canPop: false, // 필요시 동적으로 제어
      child: Scaffold(
        appBar: CustomAppBar(),
        floatingActionButton: aiListAsync.when(
          loading: () => null, // 로딩 시 FAB 숨기기
          error: (_, __) => null, // 오류 시 숨기기 또는 다른 FAB
          data: (items) {
            // 조건에 따라 FAB을 보이게 할 수 있다.
            return FloatingActionButton(
              heroTag: 'fab_chat_unique', // 고유 태그 사용
              onPressed: () {
                context.pushNamed(AppRoutes.serverDown.name);
              },
              child: const Icon(Icons.chat),
            );
          },
        ),
        body: aiListAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, st) => Center(child: Text('오류 발생: $err')),
          data: (List<VertexSearchModel> aiItems) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: CustomSearchBar()),
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
                          VertexCarousel(), // aiItems 전달
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
                SliverListNaverCard(),
              ],
            );
          },
        ),
      ),
    );
  }
}