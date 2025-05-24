import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dateapp/presentation/viewmodel/provider/search/search_blog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../core/models/vertex/vertex_search_model.dart';
import '../../core/service/crawl/blog_generation_service.dart';

// 1) Repository
class AiParserRepository {
  final FirebaseFirestore _firestore;
  AiParserRepository(this._firestore);

  /// 전체 문서 개수를 집계 쿼리로 가져옵니다.
  Future<int?> _getTotalCount() async {
    final agg = _firestore.collection('aiParserData').count();
    final snapshot = await agg.get();
    return snapshot.count;
  }

  /// 랜덤 오프셋 + limit 조합으로 문서 가져오기
  Future<List<VertexSearchModel>> fetchRandomDocs({int limit = 5}) async {
    final total = await _getTotalCount();
    if (total == 0) return [];

    final startOffset = Random().nextInt(max(1, total! - limit));
    final snap = await _firestore
        .collection('aiParserData')
        .orderBy(FieldPath.documentId)
        // .offset(startOffset)
        .limit(limit)
        .get();

    return snap.docs.map(_mapDoc).toList();
  }

  VertexSearchModel _mapDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final raw = Map<String, dynamic>.from(doc.data());
    // 태그 합치기
    final tags = List<String>.from((raw['tag'] as Map<String, dynamic>)['tag'] as List<dynamic>);
    // 크롤 콘텐츠 구조 복원
    final crawlList = (raw['crawlContent'] as Map<String, dynamic>)['crawlContent'] as List<dynamic>;
    final processed = VertexSearchModel.fromJson({
      ...raw,
      'tag': tags.join(','),
      'crawlContent': crawlList
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList(),
    });
    return processed;
  }

  Future<void> saveModel(VertexSearchModel model) async {
    final id = base64Encode(utf8.encode(model.blogMobileLink!));
    await _firestore.collection('aiParserData').doc(id).set(model.toJson());
  }
}


/// 랜덤 도큐먼트만 담당
final randomDocsProvider = FutureProvider.autoDispose<List<VertexSearchModel>>((ref) {
  final repo = ref.read(aiRepoProvider);
  return repo.fetchRandomDocs(limit: 5);
});

/// 최종 결합 + 저장
class CombinedNotifier extends AutoDisposeAsyncNotifier<List<VertexSearchModel>> {
  @override
  Future<List<VertexSearchModel>> build() async {
    // 병렬로 블로그 검색과 랜덤 문서 조회
    final blogItems = await ref.watch(blogSearchProvider.future);
    final repo = ref.read(aiRepoProvider);
    final svc = ref.read(blogSvcProvider);

    // AI 컨텐츠 생성 (랜덤 2개)
    final picks = blogItems..shuffle();
    final aiGenerated = await Future.wait(
      picks.take(2).map(svc.generateContentFromBlog),
    );

    // Firestore 랜덤 문서
    final randomDocs = await ref.watch(randomDocsProvider.future);

    // 결합 및 저장
    final combined = [...aiGenerated.whereType<VertexSearchModel>(), ...randomDocs];
    for (var model in combined) {
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

final AutoDisposeAsyncNotifierProvider<CombinedNotifier, List<VertexSearchModel>> combinedProvider = AsyncNotifierProvider.autoDispose<CombinedNotifier, List<VertexSearchModel>>(
      () => CombinedNotifier(),
);

// 기존 Providers
final aiRepoProvider = Provider<AiParserRepository>(
      (ref) => AiParserRepository(FirebaseFirestore.instance),
);
final blogSvcProvider = Provider<BlogGenerationService>(
      (ref) => BlogGenerationService(),
);

