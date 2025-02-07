import 'dart:async';

import 'package:flutter/material.dart';

class SearchTabView0 extends StatefulWidget {
  const SearchTabView0({super.key});

  @override
  State<SearchTabView0> createState() => _SearchTabView0State();
}

class _SearchTabView0State extends State<SearchTabView0> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isOpen = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  void _toggle () {
    _isOpen = !_isOpen;
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
              AnimatedBuilder(
                  animation: _animation,
                  builder: (BuildContext context, Widget? child) {

                    if (_animation.value <= 0) {
                      return SizedBox.shrink();
                    }

                    return ClipRect(
                      child: Align(
                        heightFactor: _animation.value,
                        child: Opacity(
                          opacity: _animation.value,
                          child: Container(
                            margin: const EdgeInsets.only(top: 8),
                            decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                            child: TickerAnimationScreen(),
                          ),
                        ),
                      ),
                    );
                  }
              ),
            ],
          )
        ],
      ),
    );
  }
}


class TickerAnimationController extends ChangeNotifier {
  bool _started;

  bool get started => _started;

  TickerAnimationController({bool autoStart = false}) : _started = autoStart;

  void startAnimation() {
    _started = true;
    notifyListeners();
  }

  void stopAnimation() {
    _started = false;
    notifyListeners();
  }
}

class TickerAnimationScreen extends StatefulWidget {
  const TickerAnimationScreen({super.key});

  @override
  _TickerAnimationScreenState createState() => _TickerAnimationScreenState();
}

class _TickerAnimationScreenState extends State<TickerAnimationScreen> with SingleTickerProviderStateMixin {
  final List<String> _messages = [
    "🚀 비트코인 5% 상승!",
    "📈 나스닥 1.2% 상승",
    "💰 이더리움 강세 지속",
    "🔥 애플 신제품 출시!",
    "📰 경제 뉴스 속보!",
  ];

  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _opacityAnimation;
  late final TickerAnimationController _tickerController;

  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();

    _tickerController = TickerAnimationController(autoStart: true);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _slideAnimation = TweenSequence<Offset>([
      TweenSequenceItem(tween: Tween(begin: const Offset(0, 0), end: const Offset(0, -1)), weight: 50),
      TweenSequenceItem(tween: Tween(begin: const Offset(0, 1), end: const Offset(0, 0)), weight: 50),
    ]).animate(_controller);

    _opacityAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 50),
    ]).animate(_controller);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _currentIndex.value = (_currentIndex.value + 1) % _messages.length;
        _controller.reset();

        Future.delayed(const Duration(seconds: 2), () {
          if (_tickerController.started) {
            _controller.forward();
          }
        });
      }
    });

    if (_tickerController.started) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.forward();
      });
    } else {
      _tickerController.addListener(_handleAnimationState);
    }
  }

  void _handleAnimationState() {
    if (_tickerController.started) {
      _controller.forward();
    } else {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _tickerController.dispose();
    _currentIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: SizedBox(
        width: 300,
        height: 50,
        child: ValueListenableBuilder<int>(
          valueListenable: _currentIndex,
          builder: (context, index, child) {
            int nextIndex = (index + 1) % _messages.length;
            return AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _opacityAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Text(
                      _messages[nextIndex],
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}