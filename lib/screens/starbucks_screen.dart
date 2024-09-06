// import 'dart:io';

// import 'package:flutter/material.dart';

// class StarbucksScreen extends StatefulWidget {
//   const StarbucksScreen({super.key});

//   @override
//   State<StarbucksScreen> createState() => _StarbucksScreenState();
// }

// class _StarbucksScreenState extends State<StarbucksScreen> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Stack(
//         children: <Widget>[
//           buildToolbar(),
//           buildLogo(size),
//           // DescripcionPerfil()
//         ],
//       ),
//     );
//   }

//   Widget buildLogo(Size size) {
//     return Positioned(
//       top: 10,
//       right: size.width / 2 - 25,
//       child: Image.asset(
//         'assets/images/location.png',
//         width: 50,
//         height: 50,
//       ),
//     );
//   }

//   Widget buildToolbar() {
//     return Padding(
//       padding: const EdgeInsets.only(top: 20.0),
//       child: Row(
//         children: <Widget>[
//           SizedBox(
//             width: 20,
//           ),
//           Image.asset(
//             'assets/images/location.png',
//             width: 30,
//             height: 30,
//           ),
//           Spacer(),
//           Image.asset(
//             'assets/images/location.png',
//             width: 30,
//             height: 30,
//           )
//         ],
//       ),
//     );
//   }
// }
