import 'package:flutter/material.dart';

class AnimatedOverlayEntry extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const AnimatedOverlayEntry({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
  }) : super(key: key);

  @override
  AnimatedOverlayEntryState createState() => AnimatedOverlayEntryState();
}

class AnimatedOverlayEntryState extends State<AnimatedOverlayEntry>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  Future<void> dismiss() async {
    await _controller.reverse();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }
}