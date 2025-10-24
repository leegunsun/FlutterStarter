import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/naver/blog_search_items.dart';
import '../../../feature/home/model/vertex_search_model.dart';
import '../../../../core/service/crawl/blog_generation_service.dart';
import '../../../feature/home/viewmodel/home_view_model.dart';
import '../search/search_blog.dart';

part 'conbin_provider.g.dart';

@Riverpod(keepAlive: true)
class Combined extends _$Combined {
  @override
  Future<List<VertexSearchModel>> build() async {
    // 병렬로 블로그 검색과 랜덤 문서 조회
    final List<BlogSearchItems> blogItems = await ref.watch(blogSearchProvider.future);
    final AiParserRepository repo = ref.read(aiRepoProvider);
    final BlogGenerationService svc = ref.read(blogSvcProvider);

    // AI 컨텐츠 생성 (랜덤 2개)
    final picks = blogItems..shuffle();
    final aiGenerated = await Future.wait(
      picks.take(2).map(svc.generateContentFromBlog),
    );

    // Firestore 랜덤 문서
    final randomDocs = await ref.watch(randomDocsProvider.future);

    // 결합 및 저장
    final List<VertexSearchModel> combined = [...aiGenerated.whereType<VertexSearchModel>(), ...randomDocs];
    for (VertexSearchModel model in combined) {
      await repo.saveModel(model);
    }
    return combined;
  }


  Future<void> refresh() async {
    state = const AsyncLoading();
    try {
      final result = await build();
      state = AsyncData(result);
    } catch (e, s) {
      state = AsyncError(e, s);
    }
  }
}