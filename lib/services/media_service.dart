import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:translate_swedish/models/image_model.dart';

class MediaService {
  final ImagePicker _picker = ImagePicker();
  final TextRecognizer _recognizer = TextRecognizer();
  ImageModel? image;

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

  Future<List<String>> getText(String path) async {
    final inputImage = InputImage.fromFilePath(path);
    final textDetector = await _recognizer.processImage(inputImage);

    List<String> recognizedList = [];
    for (TextBlock block in textDetector.blocks) {
      recognizedList.add(
        block.text
      );
    }
    return recognizedList;
  }
}