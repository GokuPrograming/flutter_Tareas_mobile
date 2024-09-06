import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Importa esta librería para SystemChrome
import 'package:tareas_flutter/routes/rutes.dart';
import 'package:tareas_flutter/screens/menuApp.dart';
import 'package:tareas_flutter/screens/starbucks_screen.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Asegura que los bindings se inicialicen
  // Fija la orientación a portrait
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        title: 'Material App',
        home: const Menuapp(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
////el ruteo de las screens
        // initialRoute: AppRoutes.home, // Ruta inicial
        routes: AppRoutes.routes, // Usa las rutas definidas
      ),
  
  }
}
