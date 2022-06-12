import 'package:dio/dio.dart';
import 'package:translate_swedish/config/endpoints.dart';

import 'package:translate_swedish/models/translate_response.dart';

class API {
  static Future<TranslationResponse?> getTranslation(String input) async {
    var dio = Dio();
    dio.options.contentType = 'application/json; charset=utf-8';
    dio.options.headers = <String, String>{
      'Content-Type': 'application/json; charset=utf-8',
    };
    dio.options.responseType = ResponseType.json;
    final response = await dio.get<TranslationResponse>(GoogleTranslateEndpoint.translationEndPoint(input: input));
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to get the data');
    }
  }
}