import 'package:dateapp/data/local/source/local_secure_source.dart';
import 'package:dateapp/presentation/feature/search/notifiers/search_common.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../home/model/blog_search_items.dart';
import '../../home/model/search_model.dart';
import '../../../../core/service/crawl/blog_generation_service.dart';
import '../../home/notifiers/home_view_model.dart';

part 'search_blog.g.dart';

@Riverpod()
class BlogSearch extends _$BlogSearch {
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