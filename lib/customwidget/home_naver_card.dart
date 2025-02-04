import 'package:dateapp/home/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helper/custom_helper.dart';
import '../service/api/naver/dto/search_dto.dart';
import '../service/webview/base_webview.dart';
import '../theme/custom_theme_color.dart';

class SliverListNaverCard extends StatefulWidget {
  final HomeController controller;
  const SliverListNaverCard({super.key, required this.controller});

  @override
  State<SliverListNaverCard> createState() => _SliverListNaverCardState();
}

class _SliverListNaverCardState extends State<SliverListNaverCard> {

  bool _selectIcon = false;

  Icon _showIcon () {
    if(_selectIcon) {
      return Icon(CupertinoIcons.star_fill, color: CustomThemeColor.starFill,);
    } else {
      return Icon(CupertinoIcons.star, color: CustomThemeColor.icon,);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
        itemCount: widget.controller.blogResponses.length,
        itemBuilder: (BuildContext context, int index) {
          BlogSearchItems? _item = widget.controller.blogResponses[index];

          if(_item == null) {
            return SizedBox.shrink();
          }

          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => BaseWebview(url: _item.link)));
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: Colors.white,
                  boxShadow: CustomThemeColor.cardBoxShadow
              ),
              margin: const EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Text(CustomHelper.stripHtml(_item.title), style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24
                  ),),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      margin: const EdgeInsets.only(top: 30, bottom: 10),
                      height: 190,
                      color: Colors.redAccent,
                    ),
                  ),
                  // Text(_item.bloggerlink),
                  Align(
                    alignment: Alignment.centerRight,
                    child: RichText(text: TextSpan(
                        style: TextStyle(
                            color: CustomThemeColor.cardSecondFont
                        ),
                        children: [
                          TextSpan(
                            text: _item.postdate,
                          ),
                          TextSpan(
                              text: " · "
                          ),
                          TextSpan(
                            text: _item.bloggername,
                          ),
                        ]
                    )),
                  ),
                  SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: CustomThemeColor.cardRecommendBackground,
                      borderRadius: BorderRadius.circular(8),
                    ),
                      child: Text(CustomHelper.stripHtml(_item.description),
                      ),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(onPressed: () {
                        _selectIcon = !_selectIcon;
                        setState(() {});
                      }, icon: _showIcon())
                    ],
                  )
                  // Text(_item.link),
                ],
              ),
            ),
          );
        });
  }
}
