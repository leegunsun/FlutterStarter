import '../../domain/entities/blog_entity.dart';
import '../../domain/entities/image_entity.dart';
import '../../domain/repositories/blog_repository.dart';
import '../datasources/remote/blog_search.dart';
import '../models/blog_search_items.dart';
import '../models/img_search_model.dart';

/// 블로그 Repository 구현체 (Data Layer)
///
/// ⭐ 이것이 Retrofit을 사용하는 곳입니다!
///
/// 역할:
/// 1. Retrofit으로 API 호출
/// 2. DTO (Data Transfer Object) → Entity 변환
/// 3. 에러 처리
///
/// Domain Layer는 이 구현체를 몰라도 됩니다!
/// BlogRepository 인터페이스만 알면 됩니다.
class BlogRepositoryImpl implements BlogRepository {
  final BlogSearchRestClient restClient;

  BlogRepositoryImpl(this.restClient);

  @override
  Future<List<BlogEntity>> searchBlogs({
    required String keyword,
    int display = 10,
  }) async {
    try {
      // ============ 1. Retrofit으로 API 호출 ============
      final response = await restClient.getBlogSearch(
        query: keyword,
        display: display,
      );

      // ============ 2. DTO → Entity 변환 ============
      final entities = response.items.map((dto) => _toEntity(dto)).toList();

      return entities;
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<List<ImageEntity>> searchImages({
    required String keyword,
    int display = 10,
  }) async {
    try {
      // ============ 1. Retrofit으로 API 호출 ============
      final response = await restClient.getBlogImgSearch(
        query: keyword,
        display: display,
      );

      // ============ 2. DTO → Entity 변환 ============
      final entities = response.items.map((dto) => _toImageEntity(dto)).toList();

      return entities;
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<BlogEntity?> getBlogById(String blogId) async {
    // TODO: 캐시나 로컬 DB에서 조회
    throw UnimplementedError('추후 구현 예정');
  }

  @override
  Future<List<BlogEntity>> getRecentBlogs({int limit = 20}) async {
    // TODO: 로컬 DB에서 조회
    throw UnimplementedError('추후 구현 예정');
  }

  @override
  Future<void> saveFavoriteBlog(BlogEntity blog) async {
    // TODO: 로컬 DB에 저장
    throw UnimplementedError('추후 구현 예정');
  }

  @override
  Future<List<BlogEntity>> getFavoriteBlogs() async {
    // TODO: 로컬 DB에서 조회
    throw UnimplementedError('추후 구현 예정');
  }

  @override
  Future<void> removeFavoriteBlog(String blogId) async {
    // TODO: 로컬 DB에서 삭제
    throw UnimplementedError('추후 구현 예정');
  }

  // ============ Private 메서드: DTO → Entity 변환 ============

  /// BlogSearchItems (DTO) → BlogEntity 변환
  ///
  /// ⭐ 중요: 여기서 API 응답 데이터를 비즈니스 모델로 변환합니다!
  BlogEntity _toEntity(BlogSearchItems dto) {
    return BlogEntity(
      id: dto.link, // URL을 ID로 사용
      title: _stripHtmlTags(dto.title), // HTML 태그 제거
      description: _stripHtmlTags(dto.description),
      authorName: dto.bloggername,
      authorProfileUrl: dto.bloggerlink,
      publishedAt: _parseDate(dto.postdate), // 문자열 → DateTime 변환
      thumbnailUrl: dto.thumnail,
    );
  }

  /// SearchItemDto (이미지 DTO) → ImageEntity 변환
  ImageEntity _toImageEntity(SearchItemDto dto) {
    return ImageEntity(
      id: dto.link,
      title: _stripHtmlTags(dto.title),
      imageUrl: dto.link,
      thumbnailUrl: dto.thumbnail,
      width: int.tryParse(dto.sizewidth) ?? 0,
      height: int.tryParse(dto.sizeheight) ?? 0,
    );
  }

  /// HTML 태그 제거
  ///
  /// 예: "<b>리뷰</b>" → "리뷰"
  String _stripHtmlTags(String html) {
    return html
        .replaceAll(RegExp(r'<[^>]*>'), '') // HTML 태그 제거
        .replaceAll('&amp;', '&') // HTML 엔티티 변환
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .replaceAll('&#39;', "'");
  }

  /// 날짜 문자열 파싱
  ///
  /// 예: "20250131" → DateTime(2025, 1, 31)
  DateTime _parseDate(String dateStr) {
    try {
      if (dateStr.length == 8) {
        // YYYYMMDD 형식
        final year = int.parse(dateStr.substring(0, 4));
        final month = int.parse(dateStr.substring(4, 6));
        final day = int.parse(dateStr.substring(6, 8));
        return DateTime(year, month, day);
      }
      return DateTime.now(); // 파싱 실패 시 현재 시간
    } catch (e) {
      return DateTime.now();
    }
  }

  /// 에러 처리
  Exception _handleError(dynamic error) {
    // TODO: 상세한 에러 처리 로직 추가
    if (error.toString().contains('SocketException')) {
      return NetworkException('네트워크 연결을 확인해주세요');
    }
    return ApiException('데이터를 불러오는데 실패했습니다: $error');
  }
}

/// 네트워크 예외
class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);

  @override
  String toString() => message;
}

/// API 예외
class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;
}
