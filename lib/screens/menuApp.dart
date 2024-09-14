import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:tareas_flutter/components/sladeBar.dart';

class Menuapp extends StatefulWidget {
  const Menuapp({super.key});

  @override
  State<Menuapp> createState() => _MenuappState();
}

class _MenuappState extends State<Menuapp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SladeBar(),
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
