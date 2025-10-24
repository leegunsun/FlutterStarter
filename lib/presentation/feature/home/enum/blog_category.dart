import 'package:flutter/material.dart';

enum BlogCategory {
  FOOD(Icons.restaurant),          // 맛집 추천
  CAFE(Icons.local_cafe),          // 카페 추천
  DATE(Icons.favorite),            // 데이트 장소 추천
  TRAVEL(Icons.flight),            // 여행지 추천
  ACTIVITY(Icons.directions_run),  // 체험/액티비티 추천
  CULTURE(Icons.theaters),         // 문화/전시/공연 추천
  NIGHTLIFE(Icons.nightlife),      // 바, 라운지, 클럽 등 야간 데이트 장소 추천
  OUTDOOR(Icons.park),             // 공원, 산책로 등 야외 장소 추천
  SHOPPING(Icons.shopping_bag),    // 쇼핑 장소 추천
  STAY(Icons.hotel),               // 호텔, 숙박 추천
  EVENT(Icons.event),              // 축제, 행사, 시즌별 이벤트 추천
  PET_FRIENDLY(Icons.pets),        // 반려동물 동반 가능 장소
  LUXURY(Icons.local_play),        // 고급 레스토랑, 프리미엄 서비스 추천
  BUDGET(Icons.attach_money);      // 가성비 좋은 데이트 장소 추천

  const BlogCategory(this.icon);

  final IconData icon;
}