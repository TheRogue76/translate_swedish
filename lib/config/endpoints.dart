import 'package:flutter_dotenv/flutter_dotenv.dart';

const String baseGoogleTranslateAPIEndpoint = 'https://translation.googleapis.com';

const String targetLanguage = 'en';
const String sourceLanguage = 'sv';
final String? key = dotenv.env['GOOGLE_TRANSLATE_KEY_API'];

class GoogleTranslateEndpoint {
  static String translationEndPoint({required String input}){
    return '$baseGoogleTranslateAPIEndpoint/language/translate/v2?source=$sourceLanguage&target=$targetLanguage&key=$key&q=$input';
  }
}