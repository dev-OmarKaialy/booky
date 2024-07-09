import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

class ImageHelper {
  ImageHelper._();
  static Future<Uint8List?> pickImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 30,
    );
    if (image != null) {
      return await image.readAsBytes();
    }
    return null;
  }
}
