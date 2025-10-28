

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../app/config/environment_config.dart';
import '../../../../data/local/source/local_secure_source.dart';

part 'search_common.g.dart';

@Riverpod()
class QueryTextController extends _$QueryTextController {
  QueryTextController();

  @override
  Future<TextEditingController> build() =>
      LocalSecureSource
          .get
          .getSecureItem(EnvironmentConfig.constants.SEARCH_LAST_INPUT_HISTORY)
          .then((List<dynamic> value) => (value.first is String)
          ? TextEditingController(text: value.first as String)
          : TextEditingController(text: "검색"));
}