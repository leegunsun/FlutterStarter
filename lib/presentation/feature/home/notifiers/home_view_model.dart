import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/vertex_search_model.dart';

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
    final seed = Random().nextDouble();

    final querySnap = await _firestore
        .collection('aiParserData')
        .orderBy('randomSeed')
        .startAt([seed])
        .limit(limit)
        .get();

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
    final tags = List<String>.from((raw['tag'] as Map<String, dynamic>)['tag'] as List<dynamic>);
    final crawlList = (raw['crawlContent'] as Map<String, dynamic>)['crawlContent'] as List<dynamic>;

    return VertexSearchModel.fromJson({
      ...raw,
      'tag': tags.join(','),
      'crawlContent': crawlList.map((e) => Map<String, dynamic>.from(e as Map)).toList(),
    });
  }

  Future<void> saveModel(VertexSearchModel model) async {
    final id = base64Encode(utf8.encode(model.blogMobileLink!));
    final data = model.toJson();
    data['randomSeed'] = Random().nextDouble();
    await _firestore.collection('aiParserData').doc(id).set(data);
  }

  Future<void> addRandomSeedToAllDocsManually() async {
    const batchSize = 500;
    DocumentSnapshot? lastDoc;
    int updatedTotal = 0;

    while (true) {
      print('🔍 문서 순회 중...');
      var query = _firestore.collection('aiParserData').limit(batchSize);
      if (lastDoc != null) query = query.startAfterDocument(lastDoc);

      final snapshot = await query.get();
      if (snapshot.docs.isEmpty) break;

      final batch = _firestore.batch();
      int count = 0;

      for (var doc in snapshot.docs) {
        final data = doc.data();
        if (!data.containsKey('randomSeed')) {
          batch.update(doc.reference, {'randomSeed': Random().nextDouble()});
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
