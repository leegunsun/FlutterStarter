import 'package:dateapp/core/local_database/source/local_secure_source.dart';
import 'package:dateapp/presentation/viewmodel/provider/search/search_common.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/naver/blog_search_items.dart';
import '../../home_view_model.dart';

/// 블로그 검색만 담당
final blogSearchProvider = AsyncNotifierProvider.autoDispose<BlogSearchNotifier, List<BlogSearchItems>>(() => BlogSearchNotifier());


class BlogSearchNotifier extends AutoDisposeAsyncNotifier<List<BlogSearchItems>> {
  List<String> restaurantKeywords = FirebaseRemoteConfig.instance.getString("suggest_list").split(",");
  
  
  @override
  Future<List<BlogSearchItems>> build() async {
    final svc = ref.read(blogSvcProvider);
    final query = ref.watch(queryTextControllerProvider);

    final rawQuery = query.whenOrNull() ?? '';
    final refinedQuery = (restaurantKeywords.any(rawQuery.contains)
        ? rawQuery
        : '$rawQuery 맛집')
        .replaceAll(' ', '+');

    LocalSecureSource.set.searchLastInputHistory(value: [refinedQuery]);
    
    final result = await svc.searchBlogs(refinedQuery);
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