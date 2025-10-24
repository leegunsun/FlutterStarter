/// 이미지 엔티티 (Domain Layer의 순수 비즈니스 모델)
///
/// 네이버 이미지 검색 결과를 표현하는 비즈니스 모델
class ImageEntity {
  final String id;           // 고유 식별자 (link 기반)
  final String title;        // 이미지 제목
  final String imageUrl;     // 원본 이미지 URL
  final String thumbnailUrl; // 썸네일 이미지 URL
  final int width;          // 이미지 가로 크기
  final int height;         // 이미지 세로 크기

  const ImageEntity({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.thumbnailUrl,
    required this.width,
    required this.height,
  });

  // ============ 비즈니스 로직 ============

  /// 이미지 비율 (가로 / 세로)
  double get aspectRatio {
    if (height == 0) return 1.0;
    return width / height;
  }

  /// 정사각형 이미지인지 확인
  bool get isSquare {
    return (aspectRatio - 1.0).abs() < 0.1; // 오차 범위 10%
  }

  /// 가로형 이미지인지 확인
  bool get isLandscape {
    return aspectRatio > 1.2; // 가로가 세로보다 20% 이상 길면
  }

  /// 세로형 이미지인지 확인
  bool get isPortrait {
    return aspectRatio < 0.8; // 세로가 가로보다 20% 이상 길면
  }

  /// 고화질 이미지인지 확인 (HD: 1280x720 이상)
  bool get isHighQuality {
    return width >= 1280 && height >= 720;
  }

  /// 이미지 크기 텍스트 (예: "1920 x 1080")
  String get sizeText {
    return '$width x $height';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'ImageEntity(id: $id, title: $title, size: ${sizeText})';
  }
}
