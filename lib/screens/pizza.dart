import 'package:flutter/material.dart';
import 'package:tareas_flutter/components/pizza/witgets/drinkCard.dart';
import 'package:tareas_flutter/screens/starbucks/config/colors.dart';
import 'package:tareas_flutter/components/pizza/config/drink.dart';

class Pizza extends StatefulWidget {
  const Pizza({super.key});

  @override
  State<Pizza> createState() => _StarbucksScreenState();
}

class _StarbucksScreenState extends State<Pizza> {
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
    String? image_top = 'assets/images/pizza/monito.png';
    List<Drink> list = [];
    list.add(Drink(
      'Pizza',
      'Peperoni',
      'assets/images/pizza/blur_restaurant.jfif',
      'assets/images/bean_top.png',
      'assets/images/bean_small.png',
      image_top,
      'assets/images/pizza/peperoni_imageGrande.png',
      'Pizza de pepperoni, con mucho queso,hecha con mucho cariño, mucho amor por nuestr cocinero estrella ',
      color1,
      color2,
    ));
    list.add(Drink(
      'Pizza',
      'Peperoni',
      'assets/images/pizza/blur_restaurant.jfif',
      'assets/images/bean_top.png',
      'assets/images/bean_small.png',
      image_top,
      'assets/images/pizza/gurmet.png',
      'Pizza de pepperoni, con mucho queso,hecha con mucho cariño, mucho amor por nuestr cocinero estrella ',
      color1,
      color2,
    ));
    list.add(Drink(
      'Pizza',
      'Peperoni',
      'assets/images/pizza/blur_restaurant.jfif',
      'assets/images/bean_top.png',
      'assets/images/bean_small.png',
      image_top,
      'assets/images/pizza/queso.png',
      'Pizza de pepperoni, con mucho queso,hecha con mucho cariño, mucho amor por nuestr cocinero estrella ',
      color1,
      color2,
    ));
    list.add(Drink(
      'Pizza',
      'Peperoni',
      'assets/images/pizza/blur_restaurant.jfif',
      'assets/images/bean_top.png',
      'assets/images/bean_small.png',
      image_top,
      'assets/images/pizza/peperoni_imageGrande.png',
      'Pizza de pepperoni, con mucho queso,hecha con mucho cariño, mucho amor por nuestr cocinero estrella ',
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
      right: size.width / 2.7,
      child: Image.asset('assets/images/pizza/logo.png',
          width: MediaQuery.of(context).size.width * .2),
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
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu,
              size: 30,
            ),
          ),
          Spacer(),
          Icon(
            Icons.place,
            size: 30,
          ),
          SizedBox(
            width: 30,
          )
        ],
      ),
    );
  }
}
