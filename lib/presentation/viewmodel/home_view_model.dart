import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dateapp/presentation/viewmodel/provider/search/search_blog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../core/models/naver/blog_search_items.dart';
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
    // await addRandomSeedToAllDocsManually();

    final seed = Random().nextDouble();

    final querySnap = await _firestore
        .collection('aiParserData')
        .orderBy('randomSeed')
        .startAt([seed])
        .limit(limit)
        .get();

    // 부족할 경우 반대 방향에서 추가로 가져오기
    if (querySnap.docs.length < limit) {
      final additionalSnap = await _firestore
          .collection('aiParserData')
          .orderBy('randomSeed')
          .endBefore([seed])
          .limit(limit - querySnap.docs.length)
          .get();

      return [...querySnap.docs, ...additionalSnap.docs].map(_mapDoc).toList();
    }

    return querySnap.docs.map(_mapDoc).toList();
  }


  VertexSearchModel _mapDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final raw = Map<String, dynamic>.from(doc.data());
    // 태그 합치기
    final tags = List<String>.from(
        (raw['tag'] as Map<String, dynamic>)['tag'] as List<dynamic>);
    // 크롤 콘텐츠 구조 복원
    final crawlList = (raw['crawlContent'] as Map<String,
        dynamic>)['crawlContent'] as List<dynamic>;
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
    final data = model.toJson();
    data['randomSeed'] = Random().nextDouble(); // ✅ 무작위 값 추가
    await _firestore.collection('aiParserData').doc(id).set(data);
  }

  Future<void> addRandomSeedToAllDocsManually() async {
    const batchSize = 500;
    DocumentSnapshot? lastDoc;
    int updatedTotal = 0;

    while (true) {
      print('🔍 문서 순회 중...');

      var query = _firestore.collection('aiParserData').limit(batchSize);
      if (lastDoc != null) {
        query = query.startAfterDocument(lastDoc);
      }

      final snapshot = await query.get();
      if (snapshot.docs.isEmpty) {
        print('✅ 완료됨. 더 이상 처리할 문서 없음.');
        break;
      }

      final batch = _firestore.batch();
      int count = 0;

      for (var doc in snapshot.docs) {
        final data = doc.data();
        if (!data.containsKey('randomSeed')) {
          final seed = Random().nextDouble();
          batch.update(doc.reference, {'randomSeed': seed});
          count++;
        }
      }

      if (count > 0) {
        await batch.commit();
        updatedTotal += count;
        print('✅ ${count}개 문서 업데이트 완료 (총 업데이트: $updatedTotal)');
      } else {
        print('⚠️ 이 배치에는 업데이트할 문서가 없습니다.');
      }

      lastDoc = snapshot.docs.last;
    }

    print('🎯 모든 문서 처리 완료. 최종 업데이트 수: $updatedTotal');
  }

}



/// 랜덤 도큐먼트만 담당
final AutoDisposeFutureProvider<List<VertexSearchModel>> randomDocsProvider = FutureProvider.autoDispose<List<VertexSearchModel>>((ref) {
  final AiParserRepository repo = ref.read(aiRepoProvider);
  return repo.fetchRandomDocs(limit: 5);
});

/// 최종 결합 + 저장
class CombinedNotifier extends AutoDisposeAsyncNotifier<List<VertexSearchModel>> {
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

final AutoDisposeAsyncNotifierProvider<CombinedNotifier, List<VertexSearchModel>> combinedProvider = AsyncNotifierProvider.autoDispose<CombinedNotifier, List<VertexSearchModel>>(
      () => CombinedNotifier(),
);

// 기존 Providers
final Provider<AiParserRepository> aiRepoProvider = Provider<AiParserRepository>(
      (ref) => AiParserRepository(FirebaseFirestore.instance),
);
final Provider<BlogGenerationService> blogSvcProvider = Provider<BlogGenerationService>(
      (ref) => BlogGenerationService(),
);

