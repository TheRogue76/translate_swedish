import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:translate_swedish/my_app.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}
