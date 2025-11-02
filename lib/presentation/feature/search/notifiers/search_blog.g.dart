// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_blog.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BlogSearch)
const blogSearchProvider = BlogSearchProvider._();

final class BlogSearchProvider
    extends $AsyncNotifierProvider<BlogSearch, List<BlogSearchItems>> {
  const BlogSearchProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'blogSearchProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$blogSearchHash();

  @$internal
  @override
  BlogSearch create() => BlogSearch();
}

String _$blogSearchHash() => r'f80fc52cd0e085dfec6f1b156d6216ea0b006f48';

abstract class _$BlogSearch extends $AsyncNotifier<List<BlogSearchItems>> {
  FutureOr<List<BlogSearchItems>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<List<BlogSearchItems>>, List<BlogSearchItems>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<BlogSearchItems>>,
                List<BlogSearchItems>
              >,
              AsyncValue<List<BlogSearchItems>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
