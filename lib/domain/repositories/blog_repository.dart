import '../entities/blog_entity.dart';
import '../entities/image_entity.dart';

/// 블로그 Repository 인터페이스 (Domain Layer)
///
/// ⭐ 중요: 이것은 인터페이스(추상 클래스)입니다!
/// - Domain Layer는 "무엇을" 할지만 정의 (What)
/// - Data Layer는 "어떻게" 할지 구현 (How)
///
/// 장점:
/// 1. Domain Layer는 Data Layer의 구현 방식을 알 필요 없음
/// 2. Retrofit → GraphQL로 변경해도 Domain Layer는 수정 불필요
/// 3. 테스트 시 Mock 구현체로 쉽게 교체 가능
abstract class BlogRepository {
  /// 블로그 검색
  ///
  /// [keyword] 검색 키워드
  /// [display] 검색 결과 개수 (기본값: 10)
  ///
  /// Returns: 블로그 엔티티 리스트
  ///
  /// Throws:
  /// - [NetworkException] 네트워크 오류
  /// - [ApiException] API 오류
  /// - [InvalidKeywordException] 잘못된 키워드
  Future<List<BlogEntity>> searchBlogs({
    required String keyword,
    int display = 10,
  });

  /// 이미지 검색
  ///
  /// [keyword] 검색 키워드
  /// [display] 검색 결과 개수 (기본값: 10)
  ///
  /// Returns: 이미지 엔티티 리스트
  Future<List<ImageEntity>> searchImages({
    required String keyword,
    int display = 10,
  });

  /// 블로그 ID로 조회 (캐시에서 조회 가능)
  ///
  /// [blogId] 블로그 ID (URL)
  ///
  /// Returns: 블로그 엔티티 또는 null
  Future<BlogEntity?> getBlogById(String blogId);

  /// 최근 검색한 블로그 목록 (로컬 DB에서 조회)
  ///
  /// [limit] 최대 개수 (기본값: 20)
  ///
  /// Returns: 최근 검색한 블로그 리스트
  Future<List<BlogEntity>> getRecentBlogs({int limit = 20});

  /// 블로그를 즐겨찾기에 저장
  ///
  /// [blog] 저장할 블로그 엔티티
  Future<void> saveFavoriteBlog(BlogEntity blog);

  /// 즐겨찾기한 블로그 목록 조회
  ///
  /// Returns: 즐겨찾기 블로그 리스트
  Future<List<BlogEntity>> getFavoriteBlogs();

  /// 즐겨찾기에서 삭제
  ///
  /// [blogId] 삭제할 블로그 ID
  Future<void> removeFavoriteBlog(String blogId);
}
