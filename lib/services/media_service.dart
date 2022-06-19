import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:translate_swedish/models/image_model.dart';

enum Languages {
  swedish,
  english
}

typedef TextTranslations = Map<Languages, List<String>>;

class MediaService {
  final ImagePicker _picker = ImagePicker();
  final TextRecognizer _recognizer = TextRecognizer();
  ImageModel? image;
  final OnDeviceTranslator _onDeviceTranslator = OnDeviceTranslator(sourceLanguage: TranslateLanguage.swedish, targetLanguage: TranslateLanguage.english);

  Future<ImageModel?> pickFromGallery() async {
    try {
      final selectedImage = await _picker.pickImage(source: ImageSource.gallery);
      final image = ImageModel(imagePath: selectedImage!.path);
      return image;
    } catch(e) {
      print('Image not selected');
      return null;
    }
  }

  Future<ImageModel?> pickFromCamera() async {
    try {
      final selectedImage = await _picker.pickImage(source: ImageSource.camera);
      final image = ImageModel(imagePath: selectedImage!.path);
      return image;
    } catch(e) {
      print('Image not selected');
      return null;
    }
  }

  Future<TextTranslations> getTranslatedText(String path) async {
    final inputImage = InputImage.fromFilePath(path);
    final textDetector = await _recognizer.processImage(inputImage);
    List<String> recognizedSwedishList = [];
    List<String> recognizedTranslatedList = [];
    for (TextBlock block in textDetector.blocks) {
      recognizedSwedishList.add(
        block.text
      );
      recognizedTranslatedList.add(
        await _onDeviceTranslator.translateText(block.text)
      );
    }
    return {
      Languages.swedish: recognizedSwedishList,
      Languages.english: recognizedTranslatedList,
    };
  }
}