import 'package:flutter/material.dart';
import 'package:tareas_flutter/screens/menuApp.dart';
import 'package:tareas_flutter/screens/perfil_screen.dart';
import 'package:tareas_flutter/screens/starbucks_screen.dart';

class AppRoutes {
  static const home = '/home';
  static const perfil = '/perfil_screen';
  static const Starbucks = '/starbuckScreen';

  static final routes = <String, WidgetBuilder>{
    //recibe una cadena , y un witget
    home: (context) => const Menuapp(),
    perfil: (context) => const PerfilScreen(),
    Starbucks: (context) => const StarbucksScreen(),
  };
}
