import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

import 'package:translate_swedish/pages/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return MaterialApp(
        title: 'Translate Swedish',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: const MyHomePage(),
      );
    }
    return const CupertinoApp(
      title: 'Translate Swedish',
      theme: CupertinoThemeData(
        barBackgroundColor: Colors.blueGrey,
        primaryColor: Colors.blueGrey,
      ),
      home: MyHomePage(),
    );
  }
}