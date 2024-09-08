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
  var imagen = '';
  File? image;
  final Uri _url = Uri.parse('https://github.com/GokuPrograming');

   Future pickImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage == null) return;
      final imageTemp = File(pickedImage.path);
      setState(() {
        image = imageTemp;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Galería'),
                onTap: () {
                  pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Cámara'),
                onTap: () {
                  pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
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
                perfil_header(image: image),
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
              width: MediaQuery.of(context).size.width * 0.14,
              height: MediaQuery.of(context).size.height * 0.07,
              padding: EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.black),
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
                    // print('cambiandoFoto');
                    setState(() {
                      perfil_header(image: image);
                    });
                  },
                ),
              ),
            ),
          ),

          ///poner el edit de la foto de perfil
          Positioned(
            top: MediaQuery.of(context).size.height * .105,
            left: MediaQuery.of(context).size.width * .12,
            child: Container(
              width: MediaQuery.of(context).size.width * .05,
              height: MediaQuery.of(context).size.height * .02,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.black),

              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(100),
              // ),
              child: IconButton(
                onPressed: () {
                  pickImage();
                  print('cambiando imagen del perfil');
                  setState(() {});
                },
                icon: const Icon(Icons.camera_alt_outlined),
                iconSize: 15,
                padding: EdgeInsets.zero,
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        // color: Colors.green,
                        onPressed: () async {
                          await EasyLauncher.call(number: "767676776");
                        },
                        child: const Text("Call Me"),
                      ),
                      MaterialButton(
                        onPressed: () {},
                        child: Icon(Icons.edit),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: MaterialButton(
                          onPressed: _launchUrl,
                          child: Text('Github'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: MaterialButton(
                          onPressed: _launchUrl,
                          child: Text('Github'),
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

class perfil_header extends StatelessWidget {
  const perfil_header({
    super.key,
    required this.image,
  });

  final File? image;

  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      accountName: Container(
          decoration: BoxDecoration(color: const Color.fromARGB(86, 78, 0, 0)),
          child: const Text(
            'Usuario Nmae',
            style: TextStyle(color: Colors.black),
          )),
      accountEmail: const Text('sdasdasdas'),

      ///decoracion de la imagen de fondo portada
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            // topLeft: Radius.circular(50),
            // topRight: Radius.circular(50)
            ),
        color: Colors.blue,
        image: image != null
            ? DecorationImage(
                image: FileImage(image!),
                fit: BoxFit.cover,
              )
            : const DecorationImage(
                image: AssetImage('assets/images/portadaPic.jpg'),
                fit: BoxFit.cover),
      ),
      // onDetailsPressed: () {
      //   print('presionando la pantalla');
      // },

      //inicio de sesion para otra cuenta
      otherAccountsPictures: [
        CircleAvatar(
          backgroundColor: Colors.amber,
          radius: 50,
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle, // Forma circular
              image: DecorationImage(
                image: AssetImage('assets/images/perfil_pic.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
      ],
      //cuenta del perfil actual
      currentAccountPicture: ImageperfilActual(),
    );
  }
}

class ImageperfilActual extends StatelessWidget {
  const ImageperfilActual({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //por si agregamos historias
        borderRadius: BorderRadius.circular(30),
        border: Border.all(),
        color: const Color.fromARGB(255, 208, 166, 16),
      ),
      width: MediaQuery.of(context).size.width * 0.40,
      height: MediaQuery.of(context).size.height * 0.60,
      child: CircleAvatar(
        backgroundColor: Colors.black,
        radius: 50,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FullScreenImage(
                  imageUrl:
                      'https://scontent.fcyw4-1.fna.fbcdn.net/v/t39.30808-6/404114617_3126579974315474_2568976200736145599_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=a5f93a&_nc_eui2=AeGqmQr36p62BW9TNA_C_iaDVAkyeOs37JhUCTJ46zfsmMca3dnxXUMTlcqRHR6lj4VP4hBc0JXXiXuA-0zYGnvT&_nc_ohc=YUeuzBmGtcoQ7kNvgFQosbz&_nc_ht=scontent.fcyw4-1.fna&_nc_gid=AdRDI96fte2WUwEEtXsIQCx&oh=00_AYApbV2PVaByWlaxSBN9-A6nioKZQNsk2PL6VfWv8nEVlA&oe=66E00E51',
                ),
              ),
            );
          },
          child: Container(
            decoration: const BoxDecoration(
              border: Border.symmetric(),
              // color: Colors.amber,
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
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String imageUrl;
  FullScreenImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Imagen Completa'),
      //   backgroundColor: Colors.black,
      // ),
      body: Center(
        child: Image.network(imageUrl),
      ),
      backgroundColor: Colors.black,
    );
  }
}
