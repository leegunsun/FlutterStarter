

import 'dart:async';

import 'package:dateapp/config/environment_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/local_database/source/local_secure_source.dart';


class QueryTextControllerNotifier extends AutoDisposeAsyncNotifier<TextEditingController> {

  @override
  Future<TextEditingController> build() async {
      String? data = await LocalSecureSource.get.getSecureItem(EnvironmentConfig.constants.SEARCH_LAST_INPUT_HISTORY);
      final controller = TextEditingController(text: data ?? '');
      return controller;
  }

}

final queryTextControllerProvider =
AsyncNotifierProvider.autoDispose<QueryTextControllerNotifier, TextEditingController>(QueryTextControllerNotifier.new);