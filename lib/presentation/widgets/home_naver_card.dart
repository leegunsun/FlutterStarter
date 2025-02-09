import 'package:dateapp/presentation/viewmodel/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../core/models/naver/search_model.dart';
import '../../core/utils/html_stripper_utility.dart';
import '../views/common/webview/base_webview.dart';
import '../../core/theme/custom_theme_color.dart';

class SliverListNaverCard extends StatefulWidget {
  final HomeViewModel controller;
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

          return Stack(
            clipBehavior: Clip.none,
            children: [
              GestureDetector(
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
                      const SizedBox(height: 40,),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          color: Colors.grey[100],
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            heightFactor: 0.3,
                            child: Text(
                              HtmlStripperUtility.stripHtml(_item.title),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30, bottom: 10),
                        height: 190,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(_item.thumnail ?? "https://blog.kakaocdn.net/dn/zaHVf/btsCUzDyFK6/zLwkbqViX9RYEST5DwRJmK/img.png", fit: BoxFit.cover,),
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
                          child: Text(HtmlStripperUtility.stripHtml(_item.description),
                          ),),
                      SizedBox(height: 15),
                      // Text(_item.link),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: CustomThemeColor.underlineTop,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 1,
                        // spreadRadius: 1,
                        offset: Offset(2, 2)
                      )
                    ]
                  ),
                  child: IconButton(
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      _selectIcon = !_selectIcon;
                      setState(() {});
                    },
                    icon: _showIcon(),
                  ),
                ),
              )
            ],
          );
        });
  }
}
