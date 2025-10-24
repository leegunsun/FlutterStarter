import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {

  final Color barColor;
  const CustomAppBar({
    super.key,
    // required this.controller,
    this.barColor = Colors.deepPurple,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<TextEditingController> searchText = ref.watch(queryTextControllerProvider);

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
                    Text(searchText
                        .when(
                      loading: () => '로딩중',
                      error: (err, stack) => '오류: $err',
                      data: (TextEditingController controller) => controller.text),
                      style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),),
                  ],
                ),
                Spacer(),
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