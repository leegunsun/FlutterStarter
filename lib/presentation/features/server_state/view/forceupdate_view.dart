import 'package:flutter/material.dart';

class ForceupdateView extends StatefulWidget {
  const ForceupdateView({super.key});

  @override
  State<ForceupdateView> createState() => _ForceupdateViewState();
}

class _ForceupdateViewState extends State<ForceupdateView> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Text("강제 업데이트"),
      ),
    );
  }
}
