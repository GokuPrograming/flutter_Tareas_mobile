import 'dart:ui';

class Drink {
  String? name,
      conName,
      backgroundImage,
      imageTop,
      imageSmall,
      imageBlur,
      cupImage,
      descripcion;
  late Color lightColor;
  late Color DarkColor;
  Drink(
      this.name,
      this.conName,
      this.backgroundImage,
      this.imageTop,
      this.imageSmall,
      this.imageBlur,
      this.cupImage,
      this.descripcion,
      this.lightColor,
      this.DarkColor);
}
