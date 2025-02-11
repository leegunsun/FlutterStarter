import 'package:flutter/material.dart';

import '../../../../core/utils/dialog_utility.dart';


class NavigationErrorView extends StatefulWidget {
  const NavigationErrorView({super.key});

  @override
  State<NavigationErrorView> createState() => _NavigationErrorViewState();
}

class _NavigationErrorViewState extends State<NavigationErrorView> {
  @override
  void initState() {
    super.initState();

    /// 위젯이 완전히 빌드된 후 실행되도록 보장
    WidgetsBinding.instance.addPostFrameCallback((_) {
      DialogUtility.showCustomDialog(title: "알림", message: "앱 어디서든 띄울 수 있습니다!");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.teal,
      ),
    );
  }
}