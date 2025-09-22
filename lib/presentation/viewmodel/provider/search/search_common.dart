

import 'dart:async';

import 'package:dateapp/config/environment_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/local_database/source/local_secure_source.dart';


class QueryTextControllerNotifier extends AutoDisposeAsyncNotifier<TextEditingController> {
  QueryTextControllerNotifier();

  @override
  Future<TextEditingController> build() =>
      LocalSecureSource
          .get
          .getSecureItem(EnvironmentConfig.constants.SEARCH_LAST_INPUT_HISTORY)
          .then((List<dynamic> value) => (value.first is String)
          ? TextEditingController(text: value.first as String)
          : TextEditingController(text: "검색"));
}

final AutoDisposeAsyncNotifierProvider<QueryTextControllerNotifier, TextEditingController> queryTextControllerProvider =
AsyncNotifierProvider.autoDispose<QueryTextControllerNotifier, TextEditingController>(() => QueryTextControllerNotifier());