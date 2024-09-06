import 'package:flutter/material.dart';

class Menuapp extends StatelessWidget {
  const Menuapp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/perfil_screen');
              },
              icon: Icon(Icons.person))
        ],
      ),
      body: Stack(),
    );
  }
}
