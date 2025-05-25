

import 'dart:async';

import 'package:dateapp/config/environment_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/local_database/source/local_secure_source.dart';


class QueryTextControllerNotifier extends AutoDisposeAsyncNotifier<String> {
  QueryTextControllerNotifier();

  @override
  Future<String> build() =>
      LocalSecureSource
          .get
          .getSecureItem(EnvironmentConfig.constants.SEARCH_LAST_INPUT_HISTORY)
          .then((List<dynamic> value) => (value.first is String)
          ? value.first as String
          : "검색");

  // ✅ 상태를 강제로 업데이트하는 메서드
  void updateQuery(String newValue) {
    state = AsyncData(newValue);
  }
}

final AutoDisposeAsyncNotifierProvider<QueryTextControllerNotifier, String> queryTextControllerProvider =
AsyncNotifierProvider.autoDispose<QueryTextControllerNotifier, String>(QueryTextControllerNotifier.new);