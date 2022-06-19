import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:translate_swedish/my_app.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  final translatorModelManager = OnDeviceTranslatorModelManager();
  translatorModelManager.isModelDownloaded(TranslateLanguage.swedish.bcpCode).then((isModelDownloaded) => {
    translatorModelManager.downloadModel(TranslateLanguage.swedish.bcpCode)
  });
  runApp(const MyApp());
}
