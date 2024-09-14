import 'package:flutter/material.dart';
import 'package:tareas_flutter/screens/starbucks/config/colors.dart';
import 'package:tareas_flutter/screens/starbucks/config/drink.dart';

class Drinkcard extends StatelessWidget {
  final Drink drink;
  final double pageOffset;
  final int index;

  const Drinkcard(this.pageOffset, this.index,
      {super.key, required this.drink});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double cardWidth =
        size.width - 60; // Ajusta el tamaño del cardWidth si es necesario
    final double cardHeight = size.height * .50;

    // Calcula el valor de animación basado en el pageOffset
    final double animation = Curves.easeInOut.transform(pageOffset % 1);

    return Container(
      alignment: Alignment.center,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          buildBackgroundImage(cardWidth, cardHeight, size, drink: drink),
          buildAboveCard(cardWidth, cardHeight, drink: drink, size: size),
          buildCupImage(
            size: size,
            drink: drink,
            cardWidth,
          ),
          buildBlurImage(cardWidth, cardHeight, drink: drink, size: size),
          buildSmallImage(cardWidth, cardHeight, drink: drink, size: size),
          buildTopImage(cardWidth, cardHeight, drink: drink, size: size),
          BuildTopText(drink: drink),
        ],
      ),
    );
  }
}

class buildTopImage extends StatelessWidget {
  final double cardWidth;
  final double cardHeight;
  final Drink drink;
  final Size size;

  const buildTopImage(
    this.cardWidth,
    this.cardHeight, {
    super.key,
    required this.drink,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: cardWidth * 0.05,
      bottom: cardHeight * 0.9, // Ajusta esta posición según tu diseño
      child: Image.asset(drink.imageTop.toString()),
    );
  }
}

class buildSmallImage extends StatelessWidget {
  final double cardWidth;
  final double cardHeight;
  final Drink drink;
  final Size size;

  const buildSmallImage(
    this.cardWidth,
    this.cardHeight, {
    super.key,
    required this.drink,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: cardWidth * .6,
      top: cardHeight * 0.3, // Ajusta esta posición según tu diseño
      child: Image.asset(drink.imageSmall.toString()),
    );
  }
}

class buildBlurImage extends StatelessWidget {
  final Drink drink;
  final Size size;
  final double cardHeight;
  final double cardWidth;

  const buildBlurImage(
    this.cardHeight,
    this.cardWidth, {
    super.key,
    required this.size,
    required this.drink,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: cardWidth * 0.5 - 60,
      bottom: cardHeight * 0.1, // Ajusta esta posición según tu diseño
      child: Image.asset(drink.imageBlur.toString()),
    );
  }
}

class buildCupImage extends StatelessWidget {
  final Drink drink;
  final Size size;
  final cardHeight;
  const buildCupImage(
    this.cardHeight, {
    super.key,
    required this.size,
    required this.drink,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: cardHeight * 0.45, // Ajusta esta posición según tu diseño
      right: -size.width * .2 / 2 + 50,
      child: Image.asset(
        drink.cupImage.toString(),
        height: size.height * .44 - 40,
      ),
    );
  }
}

class buildAboveCard extends StatelessWidget {
  final double cardHeight;
  final double cardWidth;
  final Size size;
  final Drink drink;

  const buildAboveCard(this.cardWidth, this.cardHeight,
      {super.key, required this.drink, required this.size});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: cardWidth,
      height: cardHeight,
      bottom: size.height * .25,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: const Color.fromARGB(112, 243, 181, 100).withOpacity(.5),
          borderRadius: BorderRadius.circular(25),
        ),
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const Text(
              'Frapuchino ',
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(197, 10, 8, 0)),
            ),
            const SizedBox(height: 10),
            Text(
              drink.descripcion.toString(),
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
            ),
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset(drink.cupImage.toString(), width: 20),
                const SizedBox(width: 5),
                Image.asset(drink.cupImage.toString(), width: 15),
                const SizedBox(width: 5),
                Image.asset(drink.cupImage.toString(), width: 10),
                const SizedBox(width: 5),
              ],
            ),
            const SizedBox(height: 15),
            Container(
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.green[200],
                  borderRadius: BorderRadius.circular(20)),
              child: const Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(width: 20),
                    Text('\$',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    SizedBox(width: 10),
                    Text(
                      '4',
                      style: TextStyle(fontSize: 19, color: Colors.white),
                    ),
                    Text(
                      '.70',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors
                              .white), // Tamaño de fuente más pequeño para "70"
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class buildBackgroundImage extends StatelessWidget {
  final Drink drink;
  final double cardHeight;
  final double cardWidth;
  final Size size;

  const buildBackgroundImage(this.cardWidth, this.cardHeight, this.size,
      {super.key, required this.drink});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: cardWidth,
      height: cardHeight,
      bottom: size.height * .25,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child:
              Image.asset(drink.backgroundImage.toString(), fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class BuildTopText extends StatelessWidget {
  final Drink drink;

  const BuildTopText({super.key, required this.drink});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      left: 20,
      child: Row(
        children: [
          Text(
            drink.name.toString(),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
                color: drink.lightColor),
          ),
          Text(
            drink.conName.toString(),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
                color: drink.lightColor),
          ),
        ],
      ),
    );
  }
}
