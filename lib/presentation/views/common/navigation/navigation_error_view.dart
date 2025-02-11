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
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   DialogUtility.showCustomDialog(title: "title", message: "message");
    // });
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
