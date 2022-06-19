import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:translate_swedish/config/network_manager.dart';
import 'package:translate_swedish/services/media_service.dart';

class TranslationInputForm extends StatefulWidget {
  const TranslationInputForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TranslationInputFormState();
}

class _TranslationInputFormState extends State<TranslationInputForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final MediaService _mediaService = MediaService();

  String currentOutput = '';

  handleSubmitPressed() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
    }
  }

  handleTextSaved(String? input) async {
    if (input != null) {
      final response = await API.getTranslation(input);
      if (response?.data?.translations?.isNotEmpty ?? false) {
        setState(() {
          currentOutput = response?.data?.translations?[0].translatedText ?? '';
        });
      }
    }
  }

  handleImagePickerPressed() async {
    try {
      final image = await _mediaService.pickFromGallery();
      if (image != null && image.imagePath != null) {
        final texts = await _mediaService.getText(image.imagePath!);
        print(texts);
      }
    } catch(e) {
      print(e);
      print('Error fetching image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Column(children: <Widget>[
              Form(
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
              Text(currentOutput),
              ElevatedButton(
                  onPressed: handleImagePickerPressed,
                  child: const Text('Scan image')
              )
            ],
          )
        )
    );
  }

}