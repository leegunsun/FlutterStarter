/// 블로그 엔티티 (Domain Layer의 순수 비즈니스 모델)
///
/// 이것은 DTO(Data Transfer Object)가 아닌 비즈니스 엔티티입니다.
/// - API 응답 구조와 독립적
/// - 앱의 비즈니스 로직에 필요한 데이터만 포함
/// - Flutter나 외부 패키지에 의존하지 않는 순수 Dart 클래스
class BlogEntity {
  final String id;              // 고유 식별자 (link를 기반으로)
  final String title;           // HTML 태그가 제거된 순수 텍스트
  final String description;     // HTML 태그가 제거된 순수 텍스트
  final String authorName;      // 블로거 이름
  final String authorProfileUrl; // 블로거 프로필 URL
  final DateTime publishedAt;   // 발행일 (파싱된 DateTime)
  final String? thumbnailUrl;   // 썸네일 이미지 URL (선택)

  const BlogEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.authorName,
    required this.authorProfileUrl,
    required this.publishedAt,
    this.thumbnailUrl,
  });

  // ============ 비즈니스 로직 (Domain Layer에서만 가능) ============

  /// 최근 7일 이내에 발행된 블로그인지 확인
  bool get isRecent {
    final now = DateTime.now();
    final difference = now.difference(publishedAt);
    return difference.inDays <= 7;
  }

  /// 오늘 발행된 블로그인지 확인
  bool get isToday {
    final now = DateTime.now();
    return publishedAt.year == now.year &&
        publishedAt.month == now.month &&
        publishedAt.day == now.day;
  }

  /// 요약 텍스트 (최대 100자)
  String get summary {
    if (description.length <= 100) return description;
    return '${description.substring(0, 100)}...';
  }

  /// 발행일 표시 텍스트 (예: "3일 전", "오늘", "2024.01.15")
  String get publishedTimeText {
    final now = DateTime.now();
    final difference = now.difference(publishedAt);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}분 전';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}시간 전';
    } else if (difference.inDays == 0) {
      return '오늘';
    } else if (difference.inDays == 1) {
      return '어제';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}일 전';
    } else {
      return '${publishedAt.year}.${publishedAt.month.toString().padLeft(2, '0')}.${publishedAt.day.toString().padLeft(2, '0')}';
    }
  }

  /// 썸네일이 있는지 확인
  bool get hasThumbnail => thumbnailUrl != null && thumbnailUrl!.isNotEmpty;

  // Equality 비교 (테스트용)
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BlogEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'BlogEntity(id: $id, title: $title, author: $authorName, publishedAt: $publishedAt)';
  }
}
