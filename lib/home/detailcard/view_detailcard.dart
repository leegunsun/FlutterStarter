import 'package:dateapp/service/webview/base_webview.dart';
import 'package:flutter/material.dart';

import '../../service/api/vertex/dto/vertext_search_dto.dart';

class DetailCardWidget extends StatelessWidget {
  final VertextSearchDto vertextSearchDto;

  const DetailCardWidget({super.key, required this.vertextSearchDto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(vertextSearchDto.title ?? ''),
              background: Image.network(
                vertextSearchDto.img.first ?? '',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ListTile(
                  title: Text('Description'),
                  subtitle: Text(vertextSearchDto.desc ?? ''),
                ),
                ListTile(
                  title: Text('Location'),
                  subtitle: Text(vertextSearchDto.location ?? ''),
                ),
              ],
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 200, // 가로 스크롤할 이미지 높이 설정
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: vertextSearchDto.img.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      vertextSearchDto.img[index] ?? "",
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: GestureDetector(
              onTap: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BaseWebview(url: vertextSearchDto.blogMobileLink ?? ''),
                  ),
                );

              },
              child: Container(
                padding: EdgeInsets.all(16),
                color: Colors.blue,
                child: Center(
                  child: Text(
                    'Go to Blog',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
