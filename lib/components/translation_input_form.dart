import 'package:flutter/material.dart';
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
  List<String> inputOfImage = [];
  List<String> outputsOfImage = [];

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

  translateImageFromPath(String path) async {
    try {
      final result = await _mediaService.getTranslatedText(path);
      inputOfImage = result[Languages.swedish]!;
      outputsOfImage = result[Languages.english]!;
      setState(() {});
    } catch(_) {
      print('Could not translate from file');
    }
  }

  handleGalleryPickerPressed() async {
    try {
      final image = await _mediaService.pickFromGallery();
      if (image != null && image.imagePath != null) {
        await translateImageFromPath(image.imagePath!);
      }
    } catch(_) {
      print('Could not fetch image');
    }
  }

  handleCameraPickerPressed() async {
    try {
      final image = await _mediaService.pickFromCamera();
      if (image != null && image.imagePath != null) {
        await translateImageFromPath(image.imagePath!);
      }
    } catch(_) {
      print('Could not fetch image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
          child: ListView(
              primary: false,
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
              children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
              Text(currentOutput,
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                    child:
                    ElevatedButton(
                        onPressed: handleGalleryPickerPressed,
                        child: const Text('Read from Gallery')
                    ),
                  ),
                  ElevatedButton(
                      onPressed: handleCameraPickerPressed,
                      child: const Text('Read from Camera')
                  ),
                ],
              ),
              ...inputOfImage.map((e) => Text(e,
                textAlign: TextAlign.center,
              )).toList(),
              ...outputsOfImage.map((e) => Text(e,
                textAlign: TextAlign.center,
              )).toList(),
            ],
          )
        );
  }

}