
import 'package:dateapp/presentation/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';

import '../../core/base/textcontroller/abs_tc.dart';
import '../views/search/search_view.dart';


class CustomAppBar<T extends BaseTextController> extends StatelessWidget implements PreferredSizeWidget {
  final T controller;
  final Color barColor;
  const CustomAppBar({
    super.key,
    required this.controller,
    this.barColor = Colors.deepPurple,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: barColor,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: barColor,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(8))
        ),
        child: SafeArea(
          child: SizedBox(
            height: preferredSize.height,
            child: Row(
              children: [
                Row(
                  children: [
                    const SizedBox(width: 20,),
                    Text("서울", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),),
                  ],
                ),
                Spacer(),
                IconButton(onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchView<T>(controller: controller,)),
                  );
                }, icon: Icon(Icons.search, color: Colors.white, size: 30,))
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60); // 높이 지정
}