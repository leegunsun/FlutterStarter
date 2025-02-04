import 'package:dateapp/theme/custom_theme_color.dart';
import 'package:flutter/material.dart';

class ServerDownPage extends StatefulWidget {
  const ServerDownPage({super.key});

  @override
  State<ServerDownPage> createState() => _ServerDownPageState();
}

class _ServerDownPageState extends State<ServerDownPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<double> _animation2;

  @override
  void initState() {
    // TODO: implement initState
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));

    _animation = Tween<double>(begin: 0 ,end: 1).animate(_animationController);
    _animation2 = Tween<double>(begin: 0 ,end: 2).animate(_animationController);

    _animationController.repeat();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              AnimatedBuilder(
                animation: _animation2,
                builder: (BuildContext context, Widget? child) {
                  return Transform.rotate(
                    angle: _animation2.value,
                    child: Center(
                      child: Icon(
                        Icons.settings,
                        color: CustomThemeColor.icon,
                        size: 200,
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                left: 0,
                right: 200,
                bottom: 20,
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (BuildContext context, Widget? child) {
                    return Transform.rotate(
                      angle: _animation.value,
                      child: Center(
                        child: Icon(
                          Icons.settings,
                          color: Colors.black,
                          size: 200,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                right: 0,
                bottom: 40,
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (BuildContext context, Widget? child) {
                    return Transform.rotate(
                      angle: _animation.value,
                      child: Center(
                        child: Icon(
                          Icons.settings,
                          color: Colors.black,
                          size: 200,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 30,),
          Text(
            "서버 점검 중입니다.",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
