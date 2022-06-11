import 'package:flutter/material.dart';

class TranslationInputForm extends StatefulWidget {
  const TranslationInputForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TranslationInputFormState();
}

class _TranslationInputFormState extends State<TranslationInputForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(hintText: "Enter the text in Swedish"),
                validator: (String? input) {
                  if(input == null) {
                    return "Please input some text for translation";
                  }
                  return null;
                },
              )
            ],
          )
      )
    );
  }

}