import 'package:flutter/material.dart';
import 'package:tareas_flutter/screens/starbucks/config/colors.dart';
import 'package:tareas_flutter/screens/starbucks/config/drink.dart';

class Drinkcard extends StatefulWidget {
  final Drink drink;
  final double pageOffset;
  final int index;

  const Drinkcard(this.pageOffset, this.index,
      {super.key, required this.drink});

  @override
  _DrinkcardState createState() => _DrinkcardState();
}

class _DrinkcardState extends State<Drinkcard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Inicializa el controlador de animación
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    // Configura la animación
    _animation = Tween<double>(begin: 0, end: 100).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceInOut,
    ));

    // Inicia la animación
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double cardWidth = size.width - 60;
    final double cardHeight = size.height * .50;

    return Container(
      alignment: Alignment.center,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          buildBackgroundImage(cardWidth, cardHeight, size,
              drink: widget.drink),
          buildAboveCard(cardWidth, cardHeight,
              drink: widget.drink, size: size),
          buildCupImage(size: size, drink: widget.drink, cardHeight),
          buildBlurImage(cardWidth, cardHeight,
              drink: widget.drink, size: size),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return buildSmallImage(
                cardWidth,
                cardHeight,
                drink: widget.drink,
                size: size,
                animationValue: _animation.value,
              );
            },
          ),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return buildTopImage(
                cardWidth,
                cardHeight,
                drink: widget.drink,
                size: size,
                animationValue: _animation.value,
              );
            },
          ),
          BuildTopText(drink: widget.drink),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class buildTopImage extends StatelessWidget {
  final double cardWidth;
  final double cardHeight;
  final Drink drink;
  final Size size;
  final double animationValue;

  const buildTopImage(
    this.cardWidth,
    this.cardHeight, {
    super.key,
    required this.drink,
    required this.size,
    required this.animationValue,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: (cardWidth * .05) + animationValue,
      bottom: cardHeight * 0.9,
      child: Image.asset(drink.imageTop.toString()),
    );
  }
}

class buildSmallImage extends StatelessWidget {
  final double cardWidth;
  final double cardHeight;
  final Drink drink;
  final Size size;
  final double animationValue;

  const buildSmallImage(
    this.cardWidth,
    this.cardHeight, {
    super.key,
    required this.drink,
    required this.size,
    required this.animationValue,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: (cardWidth * .1) + animationValue,
      top: cardHeight * 0.2,
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
      bottom: cardHeight * 0.1,
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
      bottom: cardHeight * 0.45,
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
