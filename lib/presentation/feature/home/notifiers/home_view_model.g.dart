// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Repository Provider

@ProviderFor(aiRepo)
const aiRepoProvider = AiRepoProvider._();

/// Repository Provider

final class AiRepoProvider
    extends
        $FunctionalProvider<
          AiParserRepository,
          AiParserRepository,
          AiParserRepository
        >
    with $Provider<AiParserRepository> {
  /// Repository Provider
  const AiRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'aiRepoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$aiRepoHash();

  @$internal
  @override
  $ProviderElement<AiParserRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AiParserRepository create(Ref ref) {
    return aiRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AiParserRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AiParserRepository>(value),
    );
  }
}

String _$aiRepoHash() => r'b3647ebc31843d7765e28549c936c9c21775a595';

/// BlogGenerationService Provider

@ProviderFor(blogSvc)
const blogSvcProvider = BlogSvcProvider._();

/// BlogGenerationService Provider

final class BlogSvcProvider
    extends
        $FunctionalProvider<
          BlogGenerationService,
          BlogGenerationService,
          BlogGenerationService
        >
    with $Provider<BlogGenerationService> {
  /// BlogGenerationService Provider
  const BlogSvcProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'blogSvcProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$blogSvcHash();

  @$internal
  @override
  $ProviderElement<BlogGenerationService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BlogGenerationService create(Ref ref) {
    return blogSvc(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BlogGenerationService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BlogGenerationService>(value),
    );
  }
}

String _$blogSvcHash() => r'8609b4d17ca91252ef07a72e2e1f58c72d701df1';

/// 랜덤 도큐먼트 FutureProvider

@ProviderFor(randomDocs)
const randomDocsProvider = RandomDocsProvider._();

/// 랜덤 도큐먼트 FutureProvider

final class RandomDocsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<VertexSearchModel>>,
          List<VertexSearchModel>,
          FutureOr<List<VertexSearchModel>>
        >
    with
        $FutureModifier<List<VertexSearchModel>>,
        $FutureProvider<List<VertexSearchModel>> {
  /// 랜덤 도큐먼트 FutureProvider
  const RandomDocsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'randomDocsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$randomDocsHash();

  @$internal
  @override
  $FutureProviderElement<List<VertexSearchModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<VertexSearchModel>> create(Ref ref) {
    return randomDocs(ref);
  }
}

String _$randomDocsHash() => r'0126e99f24101fc560ceab9fcb77707a89ec76f5';
