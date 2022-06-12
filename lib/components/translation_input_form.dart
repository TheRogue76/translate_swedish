import 'package:flutter/material.dart';
import 'package:translate_swedish/config/network_manager.dart';

class TranslationInputForm extends StatefulWidget {
  const TranslationInputForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TranslationInputFormState();
}

class _TranslationInputFormState extends State<TranslationInputForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String currentInput = '';

  handleSubmitPressed() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
    }
  }

  handleTextSaved(String? input) async {
    if (input != null) {
      final response = await API.getTranslation(input);
      response?.data?.translations?.forEach((element) {
        print(element.translatedText);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'Enter the text in Swedish'),
                    onSaved: handleTextSaved,
                    validator: (String? input) {
                      if(input == null) {
                        return 'Please input some text for translation';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                      onPressed: handleSubmitPressed,
                      child: const Text('Search Text')
                  )
                ],
              )
          ),
        )
    );
  }

}