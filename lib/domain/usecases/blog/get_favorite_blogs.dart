import '../../entities/blog_entity.dart';
import '../../repositories/blog_repository.dart';

/// 즐겨찾기 블로그 조회 UseCase
///
/// 즐겨찾기한 블로그를 조회하고 정렬하여 반환
class GetFavoriteBlogs {
  final BlogRepository repository;

  GetFavoriteBlogs(this.repository);

  /// 즐겨찾기 블로그 조회
  ///
  /// Returns: 즐겨찾기한 블로그 리스트 (최신순)
  Future<List<BlogEntity>> call() async {
    final blogs = await repository.getFavoriteBlogs();

    // ============ 비즈니스 규칙: 최신순 정렬 ============
    blogs.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));

    return blogs;
  }
}

/// 즐겨찾기 추가 UseCase
class AddFavoriteBlog {
  final BlogRepository repository;

  AddFavoriteBlog(this.repository);

  /// 블로그를 즐겨찾기에 추가
  ///
  /// [blog] 추가할 블로그 엔티티
  Future<void> call(BlogEntity blog) async {
    // ============ 비즈니스 규칙: 중복 확인 ============
    final favorites = await repository.getFavoriteBlogs();
    final alreadyExists = favorites.any((b) => b.id == blog.id);

    if (alreadyExists) {
      throw FavoriteAlreadyExistsException('이미 즐겨찾기에 추가된 블로그입니다');
    }

    await repository.saveFavoriteBlog(blog);
  }
}

/// 즐겨찾기 삭제 UseCase
class RemoveFavoriteBlog {
  final BlogRepository repository;

  RemoveFavoriteBlog(this.repository);

  /// 즐겨찾기에서 블로그 삭제
  ///
  /// [blogId] 삭제할 블로그 ID
  Future<void> call(String blogId) async {
    await repository.removeFavoriteBlog(blogId);
  }
}

/// 즐겨찾기 중복 예외
class FavoriteAlreadyExistsException implements Exception {
  final String message;
  FavoriteAlreadyExistsException(this.message);

  @override
  String toString() => message;
}
