import 'dart:convert';
import 'dart:typed_data';

class ImageHandler {
  static String? imageFileToBase64(Uint8List imageFile){
    String imageBase64String = base64Encode(imageFile);
    return imageBase64String;
  }
}