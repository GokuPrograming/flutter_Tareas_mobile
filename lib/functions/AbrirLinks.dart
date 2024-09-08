// import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Librería para lanzar los links

class Abrirlinks {
 final Uri link;
  Abrirlinks(this.link);
  Future<void> _launchUrl() async {
    if (!await launchUrl(link)) {
      throw Exception('No se pudo lanzar el link $link');
    }
  }

  void cargarLink() {
    _launchUrl();
  }
}
