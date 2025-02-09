import 'dart:async';
import 'dart:convert';

import 'package:dateapp/core/local_database/local_secure_source.dart';
import 'package:dateapp/core/local_database/local_secure_storage.dart';
import 'package:flutter/material.dart';

class SearchTabView0 extends StatefulWidget {
  const SearchTabView0({super.key});

  @override
  State<SearchTabView0> createState() => _SearchTabView0State();
}

class _SearchTabView0State extends State<SearchTabView0> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  List<String?> _getSearchHistory = [];
  bool _isOpen = false;
  bool b = false;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadSearchHistory();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController..duration = Duration(milliseconds: 40));
  }

  Future<void> loadSearchHistory () async {
    await LocalSecureSource.set.searchInputHistory(value: ["one", "two", "three"]);
    _getSearchHistory.clear();
    List<String?> _getSearchData = await LocalSecureSource.get.searchInputHistory();
    _getSearchHistory.addAll(_getSearchData);
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("최근 검색어"),
              Text("전체 삭제"),
            ],
          ),
          SizedBox(
            height: 40, // 내부 ListView의 높이를 명확하게 지정
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(
                10,
                    (index) => Center(
                  child: Container(
                    width: 40,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(child: Text("$index")),
                  ),
                ),
              ),
            ),
          ),
          Text("최근 검색어"),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("data"),
                  GestureDetector(
                    onTap: () {
                      _toggle();
                    },
                      child: Text("펼쳐서 보기")
                  )
                ],
              ),
              ClipRect(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 100),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, -1), // 아래에서 위로 이동
                        end: const Offset(0, 0),
                      ).animate(animation),
                      child: FadeTransition(opacity: animation, child: child),
                    );
                    // return FadeTransition(opacity: animation, child: child,);
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
                    margin: const EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: Text("data")
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
                                margin: const EdgeInsets.only(top: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
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