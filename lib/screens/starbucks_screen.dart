import 'package:flutter/material.dart';
import 'package:tareas_flutter/screens/starbucks/Components/drinkCard.dart';
import 'package:tareas_flutter/screens/starbucks/config/colors.dart';
import 'package:tareas_flutter/screens/starbucks/config/drink.dart';

class StarbucksScreen extends StatefulWidget {
  const StarbucksScreen({super.key});

  @override
  State<StarbucksScreen> createState() => _StarbucksScreenState();
}

class _StarbucksScreenState extends State<StarbucksScreen> {
  late PageController pageController;
  double pageOffset = 0;
  @override
  void initState() {
    pageController = PageController(viewportFraction: .8);
    pageController.addListener(() {
      setState(() {
        pageOffset = pageController.page!;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          BuildToolbar(),
          BuildLogo(size: size),
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: BuildPager(
              size: size,
              drinks: getDrinks(),
              pageOffset: pageOffset,
              pageController: pageController,
            ),
          ), // Pasa la lista aquí
        ],
      ),
    );
  }

  // Mueve el método getDrinks aquí, ya que es necesario en BuildPager
  List<Drink> getDrinks() {
    List<Drink> list = [];
    list.add(Drink(
      'Tirami',
      'Su',
      'assets/images/blur_image.png',
      'assets/images/bean_top.png',
      'assets/images/bean_small.png',
      'assets/images/bean_blur.png',
      'assets/images/cup.png',
      'es un cafe muy rico con sabor a cafe olor a cafe y mas cafe',
      color1,
      color2,
    ));
    list.add(Drink(
      'Tirami',
      'Su',
      'assets/images/blur_image.png',
      'assets/images/bean_top.png',
      'assets/images/bean_small.png',
      'assets/images/bean_blur.png',
      'assets/images/cup.png',
      'es un cafe muy rico con sabor a cafe olor a cafe y mas cafe',
      color1,
      color2,
    ));
    list.add(Drink(
      'Tirami',
      'Su',
      'assets/images/blur_image.png',
      'assets/images/bean_top.png',
      'assets/images/bean_small.png',
      'assets/images/bean_blur.png',
      'assets/images/cup.png',
      'es un cafe muy rico con sabor a cafe olor a cafe y mas cafe',
      color1,
      color2,
    ));

    return list; // Devuelve la lista de bebidas
  }
}

class BuildPager extends StatelessWidget {
  const BuildPager({
    super.key,
    required this.size,
    required this.drinks,
    required this.pageOffset,
    required this.pageController, // Añade el PageController aquí
  });

  final Size size;
  final List<Drink> drinks;
  final double pageOffset;
  final PageController pageController; // Recibe el PageController

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController, // Usa el PageController recibido
      itemCount: drinks.length,
      itemBuilder: (context, index) =>
          Drinkcard(drink: drinks[index], pageOffset, index),
    );
  }
}

class BuildLogo extends StatelessWidget {
  const BuildLogo({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      right: size.width / 2.25,
      child: Image.asset('assets/images/logo (2).png', width: 50, height: 50),
    );
  }
}

class BuildToolbar extends StatelessWidget {
  const BuildToolbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        children: [
          const SizedBox(width: 20),
          Image.asset(
            'assets/images/drawer.png',
            width: 30,
            height: 30,
          ),
          Spacer(),
          Image.asset(
            'assets/images/location (1).png',
            width: 30,
            height: 30,
          ),
          SizedBox(
            width: 30,
          )
        ],
      ),
    );
  }
}
