import 'package:dateapp/core/local_database/source/local_secure_source.dart';
import 'package:dateapp/presentation/viewmodel/provider/search/search_common.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/naver/blog_search_items.dart';
import '../../../../core/models/naver/search_model.dart';
import '../../../../core/service/crawl/blog_generation_service.dart';
import '../../../feature/home/viewmodel/home_view_model.dart';

/// 블로그 검색만 담당
final AsyncNotifierProvider<BlogSearchNotifier, List<BlogSearchItems>> blogSearchProvider = AsyncNotifierProvider.autoDispose<BlogSearchNotifier, List<BlogSearchItems>>(() => BlogSearchNotifier());


class BlogSearchNotifier extends AsyncNotifier<List<BlogSearchItems>> {
  List<String> restaurantKeywords = FirebaseRemoteConfig.instance.getString("suggest_list").split(",");
  
  
  @override
  Future<List<BlogSearchItems>> build() async {
    final BlogGenerationService svc = ref.read(blogSvcProvider);
    final AsyncValue<TextEditingController> query = ref.watch(queryTextControllerProvider);

    final rawQuery = query.maybeMap(
      data: (AsyncData<TextEditingController> e) => e.value.text,
      orElse: () => "",
    );

    final String refinedQuery = (restaurantKeywords.any(rawQuery.contains)
        ? rawQuery
        : '$rawQuery 맛집')
        .replaceAll(' ', '+');

    LocalSecureSource.set.searchLastInputHistory(value: [rawQuery]);
    
    final NaverApiBlogSearchModel result = await svc.searchBlogs(refinedQuery);
    return result.items.where((e) => e.isNaverBlog).toList();
  }

  void refresh () async {
    state = const AsyncLoading();
    try {
      final result = await build();
      state = AsyncData(result);
    } catch (e, s) {
      state = AsyncError(e, s);
    }
  }
}