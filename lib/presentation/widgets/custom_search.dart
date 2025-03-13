import 'package:dateapp/presentation/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomSearchBar extends StatelessWidget {
  final HomeViewModel controller;
  const CustomSearchBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

        context.push("/search", extra: controller);

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => SearchView<HomeViewModel>(controller: controller)),
        // );

        // AppsflyerController.appsflyerSdk.setOneLinkCustomDomain(["invite.mydomain.com"]);

        // AppsflyerController.setAppInviteOneLinkID(oneLinkID :"my_first_link2", callback: (value) {
        //   // String _getData = jsonEncode(value);
        //   // Map<String, dynamic> _result = jsonDecode(_getData);
        //   print("[success] runtimeType ${value.runtimeType} : $value");
        // });

        // AppsflyerController.appsflyerGenerateLink(
        //     parameters: AppsFlyerInviteLinkParams(
        //       channel: "master_create",
        //       brandDomain : "what.is.this",
        //       baseDeepLink: "testdateapp.onelink.me",
        //       referrerName: "mememememe",
        //       customerID : "cus",
        //       campaign : "first_create",
        //       customParams: {
        //           "testValue1" : "inputCustomValue1",
        //           "testValue2" : "inputCustomValue2",
        //       },
        //     ),
        //     success: (value) {
        //       String _getData = jsonEncode(value);
        //       Map<String, dynamic> _result = jsonDecode(_getData);
        //       print("[success] runtimeType ${value.runtimeType} : $value");
        //     },
        //     error: (value) {
        //       String _getData = jsonEncode(value);
        //       Map<String, dynamic> _result = jsonDecode(_getData);
        //       print("[error] runtimeType ${value.runtimeType} : $value");
        //     },
        // );

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
