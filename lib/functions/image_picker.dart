// image_picker_service.dart

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

class ImagePickerService {
  Future<File?> pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) return null;
      return File(image.path);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
      return null;
    }
  }
}
