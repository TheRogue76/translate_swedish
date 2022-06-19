import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:translate_swedish/components/app_button.dart';
import 'package:translate_swedish/config/network_manager.dart';
import 'package:translate_swedish/services/media_service.dart';

class TranslationInputForm extends StatefulWidget {
  const TranslationInputForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TranslationInputFormState();
}

class _TranslationInputFormState extends State<TranslationInputForm> {
  final TextEditingController _controller = TextEditingController(text: '');

  final MediaService _mediaService = MediaService();

  String currentInput = '';
  String currentOutput = '';
  List<String> inputOfImage = [];
  List<String> outputsOfImage = [];

  handleTextChange(String? input) {
    currentInput = input ?? '';
  }

  handleTextSubmitted(String? input) async {
    if (input != null) {
      final response = await API.getTranslation(input);
      if (response?.data?.translations?.isNotEmpty ?? false) {
        setState(() {
          currentOutput = response?.data?.translations?[0].translatedText ?? '';
        });
      }
    }
  }

  handleTextSubmitButtonChanged() {
    handleTextSubmitted(currentInput);
  }

  translateImageFromPath(String path) async {
    try {
      final result = await _mediaService.getTranslatedText(path);
      inputOfImage = result[Languages.swedish]!;
      outputsOfImage = result[Languages.english]!;
      setState(() {});
    } catch (_) {
      print('Could not translate from file');
    }
  }

  handleGalleryPickerPressed() async {
    try {
      final image = await _mediaService.pickFromGallery();
      if (image != null && image.imagePath != null) {
        await translateImageFromPath(image.imagePath!);
      }
    } catch (_) {
      print('Could not fetch image');
    }
  }

  handleCameraPickerPressed() async {
    try {
      final image = await _mediaService.pickFromCamera();
      if (image != null && image.imagePath != null) {
        await translateImageFromPath(image.imagePath!);
      }
    } catch (_) {
      print('Could not fetch image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      primary: false,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (Platform.isAndroid) ...[
              TextFormField(
                decoration: const InputDecoration(
                    hintText: 'Enter the text in Swedish'),
                onChanged: handleTextChange,
                onFieldSubmitted: handleTextSubmitted,
                controller: _controller,
                validator: (String? input) {
                  if (input == null) {
                    return 'Please input some text for translation';
                  }
                  return null;
                },
              ),
            ] else ...[
              CupertinoSearchTextField(
                autofocus: true,
                placeholder: 'Enter the text in Swedish',
                onChanged: handleTextChange,
                onSubmitted: handleTextSubmitted,
                controller: _controller,
              ),
            ],
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
              child: AppButton(
                onPressed: handleTextSubmitButtonChanged,
                child: const Text('Search Text'),
              ),
            ),
          ],
        ),
        Text(
          currentOutput,
          textAlign: TextAlign.center,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
              child: AppButton(
                  onPressed: handleGalleryPickerPressed,
                  child: const Text('Read from Gallery')),
            ),
            AppButton(
                onPressed: handleCameraPickerPressed,
                child: const Text('Read from Camera')),
          ],
        ),
        ...inputOfImage
            .map((e) => Text(
                  e,
                  textAlign: TextAlign.center,
                ))
            .toList(),
        ...outputsOfImage
            .map((e) => Text(
                  e,
                  textAlign: TextAlign.center,
                ))
            .toList(),
      ],
    );
  }
}
