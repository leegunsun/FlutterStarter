# Flutter Clean Architecture

이 프로젝트는 Clean Architecture 원칙을 따릅니다.

## 레이어 구조

```
lib/
├── app/                    # 애플리케이션 진입점 및 설정
│   ├── config/            # 환경별 설정 (debug/release)
│   ├── di/                # 의존성 주입
│   └── routes/            # 라우팅 설정
│
├── core/                   # 공유 인프라 및 유틸리티
│   ├── services/          # 인프라 서비스
│   │   ├── storage/       # 로컬 저장소
│   │   ├── fcm/          # Firebase Cloud Messaging
│   │   ├── crawl/        # 웹 크롤링
│   │   ├── kakaomap/     # 카카오맵
│   │   ├── onelink/      # AppsFlyer
│   │   └── performance/  # 성능 모니터링
│   ├── theme/            # 앱 테마
│   ├── utils/            # 유틸리티 함수들
│   └── widgets/          # 공통 재사용 위젯
│       ├── dialogs/
│       ├── layouts/
│       └── text/
│
├── data/                   # 데이터 레이어
│   ├── datasources/       # 데이터 소스
│   │   ├── local/        # 로컬 데이터 (SharedPreferences, Hive 등)
│   │   └── remote/       # 원격 데이터 (API 통신)
│   ├── models/           # 데이터 모델 (DTO)
│   └── repositories/     # Repository 구현체
│
├── domain/                 # 도메인 레이어
│   ├── entities/         # 비즈니스 엔티티
│   ├── repositories/     # Repository 인터페이스
│   └── usecases/        # 비즈니스 로직
│       ├── blog/
│       └── user/
│
└── presentation/          # 프레젠테이션 레이어
    ├── common/           # 공통 화면
    │   └── webview/
    └── features/         # 기능별 화면
        ├── home/
        │   ├── views/         # UI 화면
        │   ├── widgets/       # feature 전용 위젯
        │   ├── viewmodels/    # 상태 관리 (Riverpod)
        │   └── models/        # UI 상태 모델
        ├── search/
        ├── chat/
        ├── settings/
        └── server_state/
```

## 의존성 규칙

```
Presentation → Domain ← Data
     ↓                      ↓
   Core ←------------------┘
```

- **Presentation**: Domain에만 의존
- **Domain**: 어디에도 의존하지 않음 (순수 Dart)
- **Data**: Domain에만 의존
- **Core**: 모든 레이어에서 사용 가능

## 레이어별 책임

### 1. Domain Layer (도메인 레이어)
- **책임**: 비즈니스 로직, 엔티티, 유스케이스
- **의존성**: 없음 (순수 Dart)
- **예시**: `BlogEntity`, `GetBlogList UseCase`

### 2. Data Layer (데이터 레이어)
- **책임**: 데이터 소스 관리, Repository 구현
- **의존성**: Domain
- **예시**: API 통신, 로컬 DB, Repository 구현체

### 3. Presentation Layer (프레젠테이션 레이어)
- **책임**: UI, 상태 관리, 사용자 상호작용
- **의존성**: Domain
- **예시**: Views, ViewModels (Riverpod), Widgets

### 4. Core Layer (코어 레이어)
- **책임**: 공통 유틸리티, 공통 위젯, 인프라 서비스
- **의존성**: 없음 (독립적)
- **예시**: Theme, Utils, Common Widgets, Services

## 데이터 흐름

```
User → View → ViewModel → UseCase → Repository Interface
                                            ↓
                                    Repository Impl → DataSource → API/DB
```

## 명명 규칙

- **Entity**: `*Entity` (예: `BlogEntity`)
- **Model (DTO)**: `*Model` (예: `BlogSearchModel`)
- **Repository Interface**: `*Repository` (예: `BlogRepository`)
- **Repository Impl**: `*RepositoryImpl` (예: `BlogRepositoryImpl`)
- **UseCase**: 동사형 (예: `GetBlogList`, `SearchBlog`)
- **ViewModel**: `*ViewModel` (예: `HomeViewModel`)
- **View**: `*View` (예: `HomeView`)

## 개발 가이드

### 새로운 기능 추가 시

1. **Domain 레이어**부터 시작
   - Entity 정의
   - Repository Interface 정의
   - UseCase 작성

2. **Data 레이어** 구현
   - DataSource 작성 (API 클라이언트)
   - Model (DTO) 정의
   - Repository 구현

3. **Presentation 레이어** 구현
   - ViewModel 작성 (Riverpod)
   - View 작성
   - Feature 전용 Widget 작성

## 장점

✅ **테스트 용이성**: 레이어별 독립적 테스트 가능
✅ **유지보수성**: 관심사 분리로 코드 수정 영향 범위 최소화
✅ **확장성**: 새로운 기능 추가 시 기존 코드 영향 최소화
✅ **재사용성**: Core와 Domain 레이어의 높은 재사용성
✅ **의존성 관리**: 명확한 의존성 방향으로 순환 참조 방지
