import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../viewmodel/provider/search/search_common.dart';

class SearchTabView0 extends ConsumerStatefulWidget {
  final List<String> getSearchHistory;
  const SearchTabView0({super.key, required this.getSearchHistory});

  @override
  ConsumerState<SearchTabView0> createState() => _SearchTabView0State();
}

class _SearchTabView0State extends ConsumerState<SearchTabView0> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isOpen = false;
  bool b = false;
  
  // 인기 검색어 및 추천 검색어 데이터
  final List<String> _popularSearches = [
    "카페", "맛집", "데이트", "영화관", "공원", "박물관", "쇼핑몰", "해변"
  ];
  
  final List<String> _recommendedSearches = [
    "서울 데이트 코스", "부산 여행", "제주도 맛집", "강남 카페", "홍대 클럽"
  ];

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController..duration = Duration(milliseconds: 40));
  }

  void _toggle () {
    _isOpen = !_isOpen;
    b = !b;
    setState(() {

    });
    if(_isOpen) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "최근 검색어",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _showClearAllDialog();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Text(
                      "전체 삭제",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            child: widget.getSearchHistory.isNotEmpty
                ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.getSearchHistory.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: const EdgeInsets.only(right: 8.0, top: 4.0, bottom: 4.0),
                        child: GestureDetector(
                          onTap: () {
                            final AsyncValue<TextEditingController> controllerAsync = ref.read(queryTextControllerProvider);
                            controllerAsync.value?.text = widget.getSearchHistory[index];
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.blue[200]!),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.history,
                                  size: 16,
                                  color: Colors.blue[600],
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  widget.getSearchHistory[index],
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.blue[700],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                GestureDetector(
                                  onTap: () {
                                    _removeSearchHistory(index);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Icon(
                                      Icons.close,
                                      size: 14,
                                      color: Colors.blue[400],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        "최근 검색 기록이 없습니다",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
          ),
          
          // 인기 검색어 섹션
          _buildPopularSearchSection(),
          
          // 추천 검색어 섹션
          _buildRecommendedSearchSection(),
          
          // 실시간 뉴스 섹션
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.trending_up,
                          color: Colors.orange[600],
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "실시간 트렌드",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        _toggle();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.orange[50],
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.orange[200]!),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _isOpen ? "접기" : "펼쳐서 보기",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.orange[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              _isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                              size: 16,
                              color: Colors.orange[600],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              ClipRect(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 100),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, -1),
                        end: const Offset(0, 0),
                      ).animate(animation),
                      child: FadeTransition(opacity: animation, child: child),
                    );
                  },
                  layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
                    return Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        ...previousChildren,
                        if (currentChild != null) currentChild,
                      ],
                    );
                  },
                  child: b == false ?
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[300]!),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Colors.blue[600],
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "실시간 트렌드를 확인하려면 '펼쳐서 보기'를 눌러주세요",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                      : AnimatedBuilder(
                      animation: _animation,
                      builder: (BuildContext context, Widget? child) {

                        if (_animation.value <= 0) {
                          return SizedBox.shrink();
                        }

                        return ClipRect(
                          child: Align(
                            heightFactor: _animation.value.clamp(0.3, 1),
                            child: Opacity(
                              opacity: _animation.value.clamp(0.3, 1),
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.grey[300]!),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Container(
                                    height: 200,
                                    width: MediaQuery.of(context).size.width,
                                    child: ScrollingTickerScreen()
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
  
  // 인기 검색어 섹션 빌드
  Widget _buildPopularSearchSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              Icon(
                Icons.trending_up,
                color: Colors.red[600],
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                "인기 검색어",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 50,
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _popularSearches.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(right: 8.0, top: 4.0, bottom: 4.0),
                child: GestureDetector(
                  onTap: () {
                    final AsyncValue<TextEditingController> controllerAsync = ref.read(queryTextControllerProvider);
                    controllerAsync.value?.text = _popularSearches[index];
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.red[50]!, Colors.pink[50]!],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.red[200]!),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            color: Colors.red[500],
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _popularSearches[index],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.red[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
  
  // 추천 검색어 섹션 빌드
  Widget _buildRecommendedSearchSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              Icon(
                Icons.lightbulb_outline,
                color: Colors.green[600],
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                "추천 검색어",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: _recommendedSearches.map((search) {
              return GestureDetector(
                onTap: () {
                  final AsyncValue<TextEditingController> controllerAsync = ref.read(queryTextControllerProvider);
                  controllerAsync.value?.text = search;
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.green[200]!),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.recommend,
                        size: 16,
                        color: Colors.green[600],
                      ),
                      const SizedBox(width: 6),
                      Text(
                        search,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.green[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
  
  // 전체 삭제 확인 다이얼로그
  void _showClearAllDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text(
            '검색 기록 전체 삭제',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          content: const Text(
            '모든 검색 기록을 삭제하시겠습니까?\n이 작업은 되돌릴 수 없습니다.',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                '취소',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                // TODO: 실제 검색 기록 삭제 로직 구현
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('검색 기록이 모두 삭제되었습니다'),
                    backgroundColor: Colors.blue[600],
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                );
              },
              child: const Text(
                '삭제',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
  
  // 개별 검색 기록 삭제
  void _removeSearchHistory(int index) {
    // TODO: 실제 검색 기록 삭제 로직 구현
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('"${widget.getSearchHistory[index]}" 검색 기록이 삭제되었습니다'),
        backgroundColor: Colors.orange[600],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

class TickerContainer extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;
  const TickerContainer({super.key, required this.animation, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Align(
        heightFactor: animation.value.clamp(0.3, 1),
        child: Opacity(
          opacity: animation.value.clamp(0.3, 1),
          child: Container(
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: child
            ),
          ),
        ),
      ),
    );
  }
}


class ScrollingTickerScreen extends StatefulWidget {
  const ScrollingTickerScreen({super.key});

  @override
  _ScrollingTickerScreenState createState() => _ScrollingTickerScreenState();
}

class _ScrollingTickerScreenState extends State<ScrollingTickerScreen> {

  final List<String> _messages = [
    "🚀 비트코인 5% 상승!",
    "📈 나스닥 1.2% 상승",
    "💰 이더리움 강세 지속",
    "🔥 애플 신제품 출시!",
    "📰 경제 뉴스 속보!",
  ];

  late PageController _pageController;
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    _startScrolling();
  }


  void _startScrolling() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if(mounted) {
        if (_currentIndex < _messages.length) {
          _currentIndex++;
          _pageController.animateToPage(
            _currentIndex,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        } else {
          // 마지막 페이지에서 첫 번째 페이지로 순간 이동 (애니메이션 없이)
          _pageController.jumpToPage(0);
          _currentIndex = 1;

          // 첫 번째 페이지로 애니메이션 이동 (부드럽게 흐르는 효과)
          Future.delayed(const Duration(milliseconds: 50), () {
            if (mounted) {
              _pageController.animateToPage(
                _currentIndex,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            }
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    _pageController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: _messages.length + 1, // 마지막 메시지 다음에 첫 번째 메시지를 추가
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        if (index == _messages.length) {
          return Center(
            child: Text(
              _messages[0], // 마지막 메시지 뒤에 첫 번째 메시지를 추가
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          );
        }
        return Center(
          child: Text(
            _messages[index],
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        );
      },
    );
  }
}