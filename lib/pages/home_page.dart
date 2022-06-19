import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:translate_swedish/components/translation_input_form.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Translate the text'),
          ),
          body: const TranslationInputForm()
      );
    }
    return const CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Translate the text',
            style: TextStyle(color: Colors.white),
          ),
        ),
        resizeToAvoidBottomInset: true,
        child: TranslationInputForm(),
    );
  }
}