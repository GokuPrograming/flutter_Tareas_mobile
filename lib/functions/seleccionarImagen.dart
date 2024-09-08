import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class Seleccionarimagen {
  File? image;

  Seleccionarimagen({this.image});

  Future<File?> pickImage(ImageSource source) async {
    print('Va a seleccionar una imagen desde $source');
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage == null) return null;

      final imageTemp = File(pickedImage.path);
      image =
          imageTemp; // Asignamos la imagen seleccionada a la variable de instancia
      // print(image);
      // return image;
      return File(pickedImage.path);
    } on PlatformException catch (e) {
      ('Error al seleccionar la imagen: $e');
      return null;
    }
  }

  // Future<File?> seleccionarImagenDesdeGaleria() {
  //   return pickImage(ImageSource.gallery);
  // }

  // Future<File?> seleccionarImagenDesdeCamara() {
  //   return pickImage(ImageSource.camera);
  // }
}
