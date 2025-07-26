import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
    required this.focusScope,
    required this.textEditingController,
  });

  final FocusNode focusScope;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      focusNode: focusScope,
      controller: textEditingController,
      onTap: () {

      },
      onTapOutside: (_) => focusScope.unfocus(),
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: '검색어를 입력하세요',
      ),
    );
  }
}