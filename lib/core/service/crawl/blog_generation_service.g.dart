// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_generation_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(blogSvc)
const blogSvcProvider = BlogSvcProvider._();

final class BlogSvcProvider
    extends
        $FunctionalProvider<
          BlogGenerationService,
          BlogGenerationService,
          BlogGenerationService
        >
    with $Provider<BlogGenerationService> {
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

String _$blogSvcHash() => r'004b40268bf6058d1ef346abc68cad7a08ea5102';
