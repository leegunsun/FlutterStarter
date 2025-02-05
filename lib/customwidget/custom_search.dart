import 'package:dateapp/service/onelink/appsflyer_controller.dart';
import 'package:flutter/material.dart';

import '../search/search_view.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => SearchView()),
        // );

        AppsflyerController.appsflyerSdk.startSDK(
          onSuccess: () {
            print("AppsFlyer SDK initialized successfully.");
          },
          onError: (int errorCode, String errorMessage) {
            print(
                "Error initializing AppsFlyer SDK: Code $errorCode - $errorMessage");
          },
        );
      },
      child: Container(
        // margin: const EdgeInsets.only(bottom: 30),
        padding: const EdgeInsets.only(top: 0,bottom: 30, left: 20, right: 20),
        color: Colors.deepPurple, // 부모 컨테이너
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.tealAccent, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 10,
                offset: Offset(0, 10),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            children: [
              Text("검색해 보세요.", style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w600),),
              Spacer(),
              Icon(Icons.search, color: Colors.black, size: 30,)
            ],
          ),
        ),
      ),
    );
  }
}
