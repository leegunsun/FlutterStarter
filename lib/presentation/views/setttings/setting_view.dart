import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ElevatedButton(onPressed: () {
            if(context.locale == Locale('en', 'US')) {
              context.setLocale(Locale('ko', 'KR'));
            } else {
              context.setLocale(Locale('en', 'US'));
            }

            setState(() {});
          }, child: Text("언어 변경")),
          Text('settings').tr(),
          Text('hello').tr(args: ['Zzingong Blog']),
          Text('app_named').tr(namedArgs: {'name': 'Timer App'}),
          Text('msg'). tr(args: ['Timer App', 'Dart']),
          Text('gender').tr(gender: 'female', args: ['test']),
          Text('gender.male').tr(args: ['male']),
          Text('gender.female').tr(args: ['female']),
          Text('gender.other').tr(args: ['other']),
          Text('day').plural(1),  // 1일
          Text('day').plural(5)  // 5일
        ],
      ),
    );
  }
}
