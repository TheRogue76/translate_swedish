import 'package:flutter/material.dart';
import 'package:translate_swedish/components/translation_input_form.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Translate the text'),
      ),
      body: const TranslationInputForm()
    );
  }
}