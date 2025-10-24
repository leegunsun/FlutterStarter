// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conbin_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Combined)
const combinedProvider = CombinedProvider._();

final class CombinedProvider
    extends $AsyncNotifierProvider<Combined, List<VertexSearchModel>> {
  const CombinedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'combinedProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$combinedHash();

  @$internal
  @override
  Combined create() => Combined();
}

String _$combinedHash() => r'4fb9eaf0f0e9937d618ff6511a444eadcd5dea50';

abstract class _$Combined extends $AsyncNotifier<List<VertexSearchModel>> {
  FutureOr<List<VertexSearchModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<VertexSearchModel>>,
              List<VertexSearchModel>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<VertexSearchModel>>,
                List<VertexSearchModel>
              >,
              AsyncValue<List<VertexSearchModel>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
