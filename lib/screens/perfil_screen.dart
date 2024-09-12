import 'dart:io';
import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:tareas_flutter/functions/AbrirLinks.dart';
import 'package:tareas_flutter/functions/seleccionarImagen.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart'; //para las imagenes

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
//variables locales de entorno a modificar
  var nombreUsuario = 'Miguel Vera Franco';
  var correo = 'ronbot1223@gmail.com';
  Uri correoUri = Uri.parse('ronbot1223@gmail.com');
  var numeroTel = '4111549487';
  // ignore: non_constant_identifier_names
  Uri Github = Uri.parse('https://github.com/GokuPrograming');

  ///acciones logica Code
  //abrir la galeria
  File? image, imagePerfil;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Evita que se muestre la flecha
        centerTitle: false, // Centra el título
        title: NombreUserAppBar(nombreUsuario: nombreUsuario),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
        ],
      ),
      body: Stack(
        children: [
          DatosUser(
            nombreUsuario: nombreUsuario,
            correo: correo,
            image: image,
            imagePerfil: imagePerfil,
          ),
          //boton de ajustesPosrtada
          Positioned(
            top: MediaQuery.of(context).size.height *
                0.15, // Ajusta la distancia desde la parte superior
            left: MediaQuery.of(context).size.width *
                0.80, // Ajusta la distancia desde el borde izquierdo
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 15),
              width: MediaQuery.of(context).size.width * 0.115,
              height: MediaQuery.of(context).size.width * 0.1,
              // margin: const EdgeInsetsDirectional.fromSTEB(5, 22, 20, 5),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(100),
                ),
                color: Color.fromARGB(255, 227, 187, 201),
              ),
              child: cambiarImagenCamaraGaleria(context),
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
              child: IconButton(
                onPressed: () {
                  Seleccionarimagen selector = Seleccionarimagen();
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Wrap(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.camera_alt),
                            title: const Text('Cámara'),
                            onTap: () async {
                              try {
                                await selector.pickImage(ImageSource.camera);
                                if (selector.image != null) {
                                  setState(() {
                                    imagePerfil = selector.image;
                                  });

                                  print('Foto actualizada');
                                  print(
                                      'Imagen de perfil desde cámara: $imagePerfil');
                                  print(selector.image);

                                  DatosUser(
                                      nombreUsuario: nombreUsuario,
                                      correo: correo,
                                      image: image,
                                      imagePerfil: imagePerfil);
                                } else {
                                  print('No se seleccionó ninguna imagen');
                                }
                              } catch (e) {
                                print('Error al seleccionar la imagen: $e');
                              } finally {
                                Navigator.pop(context); // Cierra el modal
                              }
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.photo),
                            title: const Text('Galeria'),
                            onTap: () async {
                              try {
                                await selector.pickImage(ImageSource.gallery);
                                if (selector.image != null) {
                                  setState(() {
                                    imagePerfil = selector.image;
                                  });

                                  print('Foto actualizada');
                                  print(
                                      'Imagen de perfil desde cámara: $imagePerfil');
                                  print(selector.image);

                                  DatosUser(
                                      nombreUsuario: nombreUsuario,
                                      correo: correo,
                                      image: image,
                                      imagePerfil: imagePerfil);
                                } else {
                                  print('No se seleccionó ninguna imagen');
                                }
                              } catch (e) {
                                print('Error al seleccionar la imagen: $e');
                              } finally {
                                Navigator.pop(context); // Cierra el modal
                              }
                            },
                          ),
                        ],
                      );
                    },
                  );
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
                          await EasyLauncher.call(number: numeroTel);
                        },
                        child: const Text("Call Me"),
                      ),
                      MaterialButton(
                        onPressed: () {},
                        child: const Icon(Icons.edit),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        color: Colors.black,
                        child: MaterialButton(
                          onPressed: () {
                            //mandar el link a funcionar al otro archivo
                            Abrirlinks abrirlinks = Abrirlinks(Github);
                            abrirlinks.cargarLink();
                          },
                          child: const Text('Github_class'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: MaterialButton(
                          onPressed: () async {
                            await EasyLauncher.email(
                                email: correo,
                                subject: 'Hola Soy yo',
                                body: 'Hola Buen dia, quiero decirle que');
                          },
                          child: const Text('Mandame Correo'),
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

  cambiarImagenCamaraGaleria(BuildContext context) {
    return DropdownButtonHideUnderline(
        child: DropdownButton<String>(
      hint: Icon(Icons.edit),
      icon: SizedBox.shrink(), // Remueve el triángulo hacia abajo
      items: const [
        DropdownMenuItem<String>(
          value: 'Galeria',
          child: Row(
            children: [
              Icon(
                Icons.photo,
                color: Colors.amber,
              ),
              SizedBox(width: 5),
              Text(''),
            ],
          ),
        ),
        DropdownMenuItem<String>(
          value: 'Camara',
          child: Row(
            children: [
              Icon(
                Icons.camera_alt,
                color: Colors.amber,
              ),
              SizedBox(width: 5),
              Text(''),
            ],
          ),
        ),
        DropdownMenuItem<String>(
          value: 'Full',
          child: Row(
            children: [
              Icon(
                Icons.fullscreen,
                color: Colors.amber,
              ),
              SizedBox(width: 5),
              Text(''),
            ],
          ),
        ),
      ],
      onChanged: (value) async {
        if (value == 'Galeria') {
          Seleccionarimagen selector = Seleccionarimagen();
          await selector.pickImage(ImageSource.gallery);
          setState(() {
            image = selector.image;
            print('Imagen seleccionada: $image');
            DatosUser(
              nombreUsuario: nombreUsuario,
              correo: correo,
              image: image,
              imagePerfil: imagePerfil,
            );
          });
        } else if (value == 'Camara') {
          Seleccionarimagen selector = Seleccionarimagen();
          await selector.pickImage(ImageSource.camera);
          setState(() {
            image = selector.image;
            print('Imagen seleccionada: $image');
            DatosUser(
              nombreUsuario: nombreUsuario,
              correo: correo,
              image: image,
              imagePerfil: imagePerfil,
            );
          });
        } else if (value == 'Full') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FullScreenWidget(
                disposeLevel: DisposeLevel.Low,
                child: Center(
                  child: Hero(
                    tag: "smallImage",
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        decoration: BoxDecoration(
                          image: image != null
                              ? DecorationImage(
                                  image: FileImage(image!),
                                  fit: BoxFit.contain,
                                )
                              : const DecorationImage(
                                  image: AssetImage(
                                      'assets/images/portadaPic.jpg'),
                                  fit: BoxFit.contain,
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
    ));
  }
}

class DatosUser extends StatelessWidget {
  const DatosUser({
    super.key,
    required this.nombreUsuario,
    required this.correo,
    required this.image,
    required this.imagePerfil,
  });

  final String nombreUsuario;
  final String correo;
  final File? image;
  final File? imagePerfil;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(40),
                  ),
                  color: Color.fromARGB(244, 223, 247, 245),
                ),
                child: NombreUserPerfilPhoto(nombreUsuario: nombreUsuario),
              ),
              accountEmail: correoUserPerfil(correo: correo),

              ///decoracion de la imagen de fondo portada
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(),
                color: Colors.blue,
                image: image != null
                    ? DecorationImage(
                        image: FileImage(image!),
                        fit: BoxFit.cover,
                      )
                    : const DecorationImage(
                        image: AssetImage('assets/images/portadaPic.jpg'),
                        fit: BoxFit.cover,
                      ),
              ),
              // onDetailsPressed: () {
              //   print('presionando la pantalla');
              // },

              //inicio de sesion para otra cuenta
              // otherAccountsPictures: const [CuentaSecundariaPerfil()],
              //cuenta del perfil actual
              currentAccountPicture: Container(
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
                  //visualizar la imagen en grande
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullScreenWidget(
                              disposeLevel: DisposeLevel.High,
                              child: Center(
                                child: Hero(
                                    tag: "smallImage",
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: const Border.symmetric(),
                                          image: imagePerfil != null
                                              ? DecorationImage(
                                                  image:
                                                      FileImage(imagePerfil!),
                                                  fit: BoxFit.contain,
                                                )
                                              : const DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/perfil_pic.jpg'), // Tu imagen aquí
                                                  fit: BoxFit.contain,
                                                ),
                                        ),
                                      ),
                                    )
                                    // child: Image.asset(
                                    //   "assets/images/perfil_pic.jpg",
                                    //   fit: BoxFit.cover,
                                    // ),
                                    ),
                              ),
                            ),
                          ));
                    },

                    ///imagen de perfil
                    child: ImagenFotoPerfil(
                      imagePerfil: imagePerfil,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImagenFotoPerfil extends StatelessWidget {
  const ImagenFotoPerfil({
    super.key,
    required this.imagePerfil,
  });

  final File? imagePerfil;
  @override
  Widget build(BuildContext context) {
    print('llego la imagen=$imagePerfil');
    return Container(
      decoration: BoxDecoration(
        border: const Border.symmetric(),
        // color: Colors.amber,
        shape: BoxShape.circle,

        image: imagePerfil != null
            ? DecorationImage(
                image: FileImage(imagePerfil!),
                fit: BoxFit.cover,
              )
            : const DecorationImage(
                image: AssetImage(
                    'assets/images/perfil_pic.jpg'), // Tu imagen aquí
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}

class NombreUserPerfilPhoto extends StatelessWidget {
  const NombreUserPerfilPhoto({
    super.key,
    required this.nombreUsuario,
  });

  final String nombreUsuario;

  @override
  Widget build(BuildContext context) {
    return Text(
      nombreUsuario,
      style: const TextStyle(color: Colors.black),
    );
  }
}

class correoUserPerfil extends StatelessWidget {
  const correoUserPerfil({
    super.key,
    required this.correo,
  });

  final String correo;

  @override
  Widget build(BuildContext context) {
    return Text(correo);
  }
}

class CuentaSecundariaPerfil extends StatelessWidget {
  const CuentaSecundariaPerfil({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
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
    );
  }
}

class NombreUserAppBar extends StatelessWidget {
  const NombreUserAppBar({
    super.key,
    required this.nombreUsuario,
  });

  final String nombreUsuario;

  @override
  Widget build(BuildContext context) {
    return Text(nombreUsuario);
  }
}
