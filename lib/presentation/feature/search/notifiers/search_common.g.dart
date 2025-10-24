// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_common.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(QueryTextController)
const queryTextControllerProvider = QueryTextControllerProvider._();

final class QueryTextControllerProvider
    extends $AsyncNotifierProvider<QueryTextController, TextEditingController> {
  const QueryTextControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'queryTextControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$queryTextControllerHash();

  @$internal
  @override
  QueryTextController create() => QueryTextController();
}

String _$queryTextControllerHash() =>
    r'199cdada66e91e5c0d73c97ec553a8037b904e28';

abstract class _$QueryTextController
    extends $AsyncNotifier<TextEditingController> {
  FutureOr<TextEditingController> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<TextEditingController>, TextEditingController>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<TextEditingController>,
                TextEditingController
              >,
              AsyncValue<TextEditingController>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
