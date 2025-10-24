import '../../entities/blog_entity.dart';
import '../../repositories/blog_repository.dart';

/// 블로그 검색 UseCase
///
/// ⭐ UseCase의 역할:
/// - 비즈니스 로직을 캡슐화
/// - Repository를 호출하여 데이터를 가져옴
/// - 비즈니스 규칙을 적용 (검증, 정렬, 필터링 등)
///
/// 장점:
/// 1. ViewModel에서 비즈니스 로직을 분리
/// 2. 재사용 가능 (여러 곳에서 동일한 로직 사용)
/// 3. 테스트 용이 (비즈니스 로직만 독립적으로 테스트 가능)
class SearchBlogs {
  final BlogRepository repository;

  SearchBlogs(this.repository);

  /// 블로그 검색 실행
  ///
  /// [keyword] 검색 키워드
  /// [display] 검색 결과 개수
  ///
  /// Returns: 최신순으로 정렬된 블로그 리스트
  ///
  /// Throws:
  /// - [InvalidKeywordException] 키워드가 2자 미만일 때
  Future<List<BlogEntity>> call({
    required String keyword,
    int display = 10,
  }) async {
    // ============ 비즈니스 규칙 1: 키워드 검증 ============
    final trimmedKeyword = keyword.trim();

    if (trimmedKeyword.isEmpty) {
      throw InvalidKeywordException('검색어를 입력해주세요');
    }

    if (trimmedKeyword.length < 2) {
      throw InvalidKeywordException('검색어는 2자 이상 입력해주세요');
    }

    // ============ 비즈니스 규칙 2: Repository 호출 ============
    final blogs = await repository.searchBlogs(
      keyword: trimmedKeyword,
      display: display,
    );

    // ============ 비즈니스 규칙 3: 최신순 정렬 ============
    // Repository에서 이미 정렬된 데이터를 주더라도
    // Domain Layer에서 명시적으로 정렬 보장
    blogs.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));

    return blogs;
  }
}

/// 최근 블로그만 검색하는 UseCase
///
/// SearchBlogs를 확장한 UseCase
/// 7일 이내 블로그만 필터링
class SearchRecentBlogs {
  final BlogRepository repository;

  SearchRecentBlogs(this.repository);

  /// 최근 블로그 검색 실행
  ///
  /// Returns: 7일 이내 발행된 블로그만 반환
  Future<List<BlogEntity>> call({
    required String keyword,
    int display = 10,
  }) async {
    // SearchBlogs UseCase 재사용
    final searchBlogs = SearchBlogs(repository);
    final allBlogs = await searchBlogs(keyword: keyword, display: display * 2);

    // ============ 비즈니스 규칙: 최근 7일 필터링 ============
    final recentBlogs = allBlogs.where((blog) => blog.isRecent).toList();

    // 요청한 개수만큼만 반환
    return recentBlogs.take(display).toList();
  }
}

/// 키워드 검증 예외
class InvalidKeywordException implements Exception {
  final String message;
  InvalidKeywordException(this.message);

  @override
  String toString() => message;
}
