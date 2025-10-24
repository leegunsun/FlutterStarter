# Domain Layer 사용 예시

이 문서는 **Retrofit과 Domain Layer의 차이**를 실제 코드로 보여줍니다.

---

## 🔴 Retrofit만 사용 (Domain Layer 없이)

### 문제점 예시

```dart
// ❌ ViewModel에서 Retrofit을 직접 사용
class HomeViewModel extends StateNotifier<AsyncValue<List<BlogSearchItems>>> {
  final BlogSearchRestClient restClient;  // ← Retrofit 직접 의존

  Future<void> search(String keyword) async {
    // 문제 1: 비즈니스 로직이 ViewModel에 분산
    if (keyword.trim().length < 2) {
      // 키워드 검증 로직이 여기저기 중복됨
      return;
    }

    // 문제 2: DTO를 직접 사용
    final response = await restClient.getBlogSearch(query: keyword);

    // 문제 3: HTML 태그 제거 로직이 UI Layer에 있음
    final blogs = response.items.map((item) {
      return BlogSearchItems(
        title: item.title.replaceAll(RegExp(r'<[^>]*>'), ''),
        // ... 변환 로직이 UI Layer에 있음
      );
    }).toList();

    // 문제 4: API 응답 구조에 종속
    // NaverApiBlogSearchModel이 변경되면 모든 ViewModel 수정 필요
    state = AsyncValue.data(blogs);
  }
}

// View에서 사용
Text(blog.title)  // ← HTML 태그가 그대로 표시될 수 있음
Text(blog.postdate)  // ← "20250131" 문자열 그대로 표시
```

**문제점**:
- ❌ 비즈니스 로직이 ViewModel에 분산 → 중복 코드
- ❌ DTO를 직접 사용 → API 변경 시 전체 수정
- ❌ 테스트 어려움 → Retrofit Mock 필요
- ❌ 네이버 API → 구글 API 변경 시 모든 코드 수정

---

## 🟢 Domain Layer 사용 (Clean Architecture)

### 1. DI 설정 (app/di/)

```dart
// app/di/injector.dart
import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';

// ============ Data Layer ============

// Dio 인스턴스
final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(
    baseUrl: 'https://openapi.naver.com',
    headers: {
      'X-Naver-Client-Id': 'YOUR_CLIENT_ID',
      'X-Naver-Client-Secret': 'YOUR_CLIENT_SECRET',
    },
  ));
});

// Retrofit RestClient
final blogSearchRestClientProvider = Provider<BlogSearchRestClient>((ref) {
  final dio = ref.watch(dioProvider);
  return BlogSearchRestClient(dio);
});

// ============ Repository (Data → Domain 연결) ============

final blogRepositoryProvider = Provider<BlogRepository>((ref) {
  final restClient = ref.watch(blogSearchRestClientProvider);
  return BlogRepositoryImpl(restClient);  // ← 구현체 주입
});

// ============ UseCases ============

final searchBlogsUseCaseProvider = Provider<SearchBlogs>((ref) {
  final repository = ref.watch(blogRepositoryProvider);
  return SearchBlogs(repository);
});

final searchRecentBlogsUseCaseProvider = Provider<SearchRecentBlogs>((ref) {
  final repository = ref.watch(blogRepositoryProvider);
  return SearchRecentBlogs(repository);
});

final addFavoriteBlogUseCaseProvider = Provider<AddFavoriteBlog>((ref) {
  final repository = ref.watch(blogRepositoryProvider);
  return AddFavoriteBlog(repository);
});
```

---

### 2. ViewModel에서 UseCase 사용

```dart
// presentation/features/home/viewmodels/home_viewmodel.dart
import 'package:riverpod/riverpod.dart';
import '../../../../domain/entities/blog_entity.dart';
import '../../../../domain/usecases/blog/search_blogs.dart';

// ViewModel
class HomeViewModel extends StateNotifier<AsyncValue<List<BlogEntity>>> {
  final SearchBlogs searchBlogs;  // ← UseCase 의존

  HomeViewModel(this.searchBlogs) : super(const AsyncValue.loading());

  // ✅ 비즈니스 로직은 UseCase에 있음 (ViewModel은 단순함)
  Future<void> search(String keyword) async {
    state = const AsyncValue.loading();

    try {
      final blogs = await searchBlogs(keyword: keyword);  // ← UseCase 호출
      state = AsyncValue.data(blogs);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

// Provider 정의
final homeViewModelProvider = StateNotifierProvider.autoDispose<
    HomeViewModel, AsyncValue<List<BlogEntity>>>(
  (ref) {
    final searchBlogs = ref.watch(searchBlogsUseCaseProvider);
    return HomeViewModel(searchBlogs);
  },
);
```

---

### 3. View에서 사용

```dart
// presentation/features/home/views/home_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final blogsState = ref.watch(homeViewModelProvider);
    final viewModel = ref.read(homeViewModelProvider.notifier);

    return Scaffold(
      body: Column(
        children: [
          // 검색창
          TextField(
            onSubmitted: (keyword) => viewModel.search(keyword),
          ),

          // 검색 결과
          blogsState.when(
            data: (blogs) => ListView.builder(
              itemCount: blogs.length,
              itemBuilder: (context, index) {
                final blog = blogs[index];

                return ListTile(
                  // ✅ Entity의 비즈니스 로직 사용
                  title: Text(blog.title),  // ← HTML 태그 이미 제거됨
                  subtitle: Text(blog.publishedTimeText),  // ← "3일 전" 형식
                  trailing: blog.isRecent
                    ? Chip(label: Text('NEW'))  // ← 비즈니스 로직
                    : null,
                );
              },
            ),
            loading: () => CircularProgressIndicator(),
            error: (error, _) => Text('오류: $error'),
          ),
        ],
      ),
    );
  }
}
```

---

### 4. 다른 UseCase 사용 예시

```dart
// 최근 블로그만 검색
class RecentBlogsViewModel extends StateNotifier<AsyncValue<List<BlogEntity>>> {
  final SearchRecentBlogs searchRecentBlogs;  // ← 다른 UseCase

  RecentBlogsViewModel(this.searchRecentBlogs)
    : super(const AsyncValue.loading());

  Future<void> search(String keyword) async {
    state = const AsyncValue.loading();

    try {
      // ✅ 7일 이내 블로그만 자동 필터링
      final blogs = await searchRecentBlogs(keyword: keyword);
      state = AsyncValue.data(blogs);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

// 즐겨찾기 추가
class FavoriteButton extends ConsumerWidget {
  final BlogEntity blog;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: Icon(Icons.favorite_border),
      onPressed: () async {
        final addFavorite = ref.read(addFavoriteBlogUseCaseProvider);

        try {
          await addFavorite(blog);  // ← UseCase 호출
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('즐겨찾기에 추가되었습니다')),
          );
        } on FavoriteAlreadyExistsException catch (e) {
          // ✅ 비즈니스 예외 처리
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString())),
          );
        }
      },
    );
  }
}
```

---

## 📊 비교 정리

| 항목 | Retrofit만 사용 | Domain Layer 사용 |
|------|---------------|------------------|
| **비즈니스 로직** | ViewModel에 분산 | UseCase에 집중 |
| **데이터 모델** | DTO 직접 사용 | Entity 사용 |
| **API 변경** | 전체 코드 수정 | Repository만 수정 |
| **테스트** | Retrofit Mock 필요 | Repository Mock만 |
| **재사용성** | 낮음 (중복 코드) | 높음 (UseCase 재사용) |
| **ViewModel 복잡도** | 높음 | 낮음 |

---

## 🎯 핵심 차이

### Retrofit의 역할
```dart
// ✅ Retrofit: "API를 어떻게 호출할까?" (How)
@RestApi()
abstract class BlogSearchRestClient {
  @GET("v1/search/blog.json")
  Future<NaverApiBlogSearchModel> getBlogSearch(...);
}
```

### Domain Layer의 역할
```dart
// ✅ Domain: "무엇을 해야 할까?" (What)
class SearchBlogs {
  Future<List<BlogEntity>> call(String keyword) {
    // 비즈니스 규칙:
    // 1. 키워드 검증
    // 2. 검색 실행
    // 3. 최신순 정렬
  }
}
```

---

## ✅ 결론

**Retrofit ≠ Domain Layer 대체품**

- Retrofit은 Data Layer의 도구 (API 통신)
- Domain Layer는 비즈니스 로직의 핵심
- 둘 다 필요하며 서로 보완 관계

**장점**:
1. ✅ 비즈니스 로직 재사용
2. ✅ 테스트 용이
3. ✅ API 변경에 강함
4. ✅ 코드 유지보수 쉬움
