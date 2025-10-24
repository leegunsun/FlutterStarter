import '../../entities/image_entity.dart';
import '../../repositories/blog_repository.dart';

/// 이미지 검색 UseCase
class SearchImages {
  final BlogRepository repository;

  SearchImages(this.repository);

  /// 이미지 검색 실행
  ///
  /// [keyword] 검색 키워드
  /// [display] 검색 결과 개수
  ///
  /// Returns: 이미지 엔티티 리스트
  Future<List<ImageEntity>> call({
    required String keyword,
    int display = 10,
  }) async {
    // ============ 비즈니스 규칙 1: 키워드 검증 ============
    final trimmedKeyword = keyword.trim();

    if (trimmedKeyword.isEmpty) {
      throw InvalidKeywordException('검색어를 입력해주세요');
    }

    // ============ 비즈니스 규칙 2: Repository 호출 ============
    final images = await repository.searchImages(
      keyword: trimmedKeyword,
      display: display,
    );

    return images;
  }
}

/// 고화질 이미지만 검색하는 UseCase
class SearchHighQualityImages {
  final BlogRepository repository;

  SearchHighQualityImages(this.repository);

  /// 고화질 이미지만 검색
  ///
  /// Returns: HD(1280x720) 이상 이미지만 반환
  Future<List<ImageEntity>> call({
    required String keyword,
    int display = 10,
  }) async {
    final searchImages = SearchImages(repository);
    final allImages = await searchImages(keyword: keyword, display: display * 2);

    // ============ 비즈니스 규칙: 고화질만 필터링 ============
    final hdImages = allImages.where((image) => image.isHighQuality).toList();

    return hdImages.take(display).toList();
  }
}

class InvalidKeywordException implements Exception {
  final String message;
  InvalidKeywordException(this.message);

  @override
  String toString() => message;
}
