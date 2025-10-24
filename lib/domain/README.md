# Domain Layer

도메인 레이어는 비즈니스 로직과 엔티티를 포함합니다. 이 레이어는 다른 레이어에 의존하지 않으며, 순수한 Dart 코드로만 구성됩니다.

## 디렉터리 구조

```
domain/
├── entities/           # 도메인 엔티티 (비즈니스 모델)
├── repositories/       # Repository 인터페이스 (추상 클래스)
└── usecases/          # 비즈니스 로직 (Use Cases)
    ├── blog/
    └── user/
```

## 사용 예시

### 1. Entity 정의
```dart
// domain/entities/blog_entity.dart
class BlogEntity {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;

  BlogEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  });
}
```

### 2. Repository Interface 정의
```dart
// domain/repositories/blog_repository.dart
abstract class BlogRepository {
  Future<List<BlogEntity>> getBlogs();
  Future<BlogEntity> getBlogById(String id);
  Future<void> saveBlog(BlogEntity blog);
}
```

### 3. UseCase 정의
```dart
// domain/usecases/blog/get_blog_list.dart
class GetBlogList {
  final BlogRepository repository;

  GetBlogList(this.repository);

  Future<List<BlogEntity>> call() {
    return repository.getBlogs();
  }
}
```

## 원칙

1. **의존성 역전**: Domain은 어떤 레이어에도 의존하지 않음
2. **순수 Dart**: Flutter나 외부 패키지 의존성 최소화
3. **비즈니스 로직 중심**: UI나 데이터 저장 방식과 독립적
