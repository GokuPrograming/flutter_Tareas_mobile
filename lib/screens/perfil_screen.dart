import 'dart:io';
import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart'; //para las imagenes

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  //abrir la galeria
  File? image;
  final Uri _url = Uri.parse('https://github.com/GokuPrograming');

  Future pickImage() async {
    print('va a mandar a elegir imagen');
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  ///abrirlinks

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Evita que se muestre la flecha
        centerTitle: false, // Centra el título
        title: const Text('Nombre del Usuario'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
      ),
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(86, 78, 0, 0)),
                      child: const Text(
                        'Usuario Nmae',
                        style: TextStyle(color: Colors.black),
                      )),
                  accountEmail: const Text('sdasdasdas'),

                  ///decoracion de la imagen de fondo
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        // topLeft: Radius.circular(50),
                        // topRight: Radius.circular(50)
                        ),
                    color: Colors.blue,
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://scontent.fcyw4-1.fna.fbcdn.net/v/t39.30808-6/428507889_3179398732366931_7196028158240576574_n.jpg?stp=cp6_dst-jpg&_nc_cat=109&ccb=1-7&_nc_sid=cc71e4&_nc_eui2=AeEEptovuYNiBo95vYb-Yp8ZORM-e4yi-jM5Ez57jKL6MxxyqOqcoLkJfELQ-1ISjhWNSDwSrJPN5esOx3xzdxg0&_nc_ohc=LT7t9gsewyoQ7kNvgFcbPhb&_nc_ht=scontent.fcyw4-1.fna&_nc_gid=AxHXX92sXiJmN5himRn4jvT&oh=00_AYDPwkw13qen2vEKeXGuoaCe2RMY9WYXc0qfL6fInOaksg&oe=66DFF61B'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  //inicio de sesion para otra cuenta
                  otherAccountsPictures: [
                    CircleAvatar(
                      backgroundColor: Colors.amber,
                      radius: 50,
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle, // Forma circular
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://th.bing.com/th/id/OIP.xmZEB-EZTOSKPAi0IeSS4AHaEy?rs=1&pid=ImgDetMain'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  ],
                  //cuenta del perfil actual
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 50,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://scontent.fcyw4-1.fna.fbcdn.net/v/t39.30808-6/404114617_3126579974315474_2568976200736145599_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=a5f93a&_nc_eui2=AeGqmQr36p62BW9TNA_C_iaDVAkyeOs37JhUCTJ46zfsmMca3dnxXUMTlcqRHR6lj4VP4hBc0JXXiXuA-0zYGnvT&_nc_ohc=YUeuzBmGtcoQ7kNvgFQosbz&_nc_ht=scontent.fcyw4-1.fna&_nc_gid=AdRDI96fte2WUwEEtXsIQCx&oh=00_AYApbV2PVaByWlaxSBN9-A6nioKZQNsk2PL6VfWv8nEVlA&oe=66E00E51'), // Tu imagen aquí
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          //boton de ajustesPosrtada
          Positioned(
            top: MediaQuery.of(context).size.height *
                0.12, // Ajusta la distancia desde la parte superior
            left: MediaQuery.of(context).size.width *
                0.80, // Ajusta la distancia desde el borde izquierdo
            child: Container(
              width: MediaQuery.of(context).size.width * 0.20,
              height: MediaQuery.of(context).size.height * 0.10,
              padding: EdgeInsets.all(10),
              child: IconButton(
                icon: const Icon(
                  Icons.mode_edit_outlined,
                  // size: 30,
                  color: Colors
                      .white, // Asegúrate de que el icono sea visible sobre el fondo negro
                ),
                padding: EdgeInsets.zero,
                onPressed: () {
                  pickImage();
                  print('cambiandoFoto');
                  // setState(() {});
                },
              ),
            ),
          ),

          //contenedor de abajo
          Positioned(
            top: MediaQuery.of(context).size.height * .20,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        // color: Colors.green,
                        onPressed: () async {
                          await EasyLauncher.call(number: "767676776");
                        },
                        child: const Text("Call to a number"),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: MaterialButton(
                          onPressed: _launchUrl,
                          child: Text('Github->GokuPrograming'),
                        ),
                      ),
                    ],
                  ), Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: MaterialButton(
                          onPressed: _launchUrl,
                          child: Text('Github->GokuPrograming'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
