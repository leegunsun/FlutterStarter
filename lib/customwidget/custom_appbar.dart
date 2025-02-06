
import 'package:dateapp/home/home_controller.dart';
import 'package:flutter/material.dart';

import '../search/search_view.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final HomeController controller;
  const CustomAppBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.deepPurple,
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
                    MaterialPageRoute(builder: (context) => SearchView<HomeController>(controller: controller,)),
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