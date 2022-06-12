const String baseGoogleTranslateAPIEndpoint = 'https://translation.googleapis.com';

const String targetLanguage = 'en';
const String sourceLanguage = 'sv';
const String key = 'test';

class GoogleTranslateEndpoint {
  static String translationEndPoint({required String input}){
    return '$baseGoogleTranslateAPIEndpoint/language/translate/v2?source=$sourceLanguage&target=$targetLanguage&key=$key&q=$input';
  }
}