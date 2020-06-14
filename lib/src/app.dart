import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_app_example/screens/home.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return defaultTargetPlatform == TargetPlatform.android
        ? MaterialApp(
          title: "Hive Basic Tut",
          home: Home(),
        )
        : CupertinoApp(
          title: "Hive Basic Tut",
          home: Home(),
        );
  }
}
