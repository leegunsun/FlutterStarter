

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/config/environment_config.dart';
import '../../../../core/local_database/source/local_secure_source.dart';


class QueryTextControllerNotifier extends AsyncNotifier<TextEditingController> {
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

final AsyncNotifierProvider<QueryTextControllerNotifier, TextEditingController> queryTextControllerProvider =
AsyncNotifierProvider.autoDispose<QueryTextControllerNotifier, TextEditingController>(() => QueryTextControllerNotifier());