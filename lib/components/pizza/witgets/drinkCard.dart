import 'package:flutter/material.dart';
import 'package:tareas_flutter/components/pizza/config/colors.dart';
import 'package:tareas_flutter/components/pizza/config/drink.dart';

class Drinkcard extends StatefulWidget {
  final Drink drink;
  final double pageOffset; // Añadir pageOffset
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

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    // Configura la animación
    _animation = Tween<double>(begin: 0, end: 100).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCirc,
    ));

    // Comienza la animación inmediatamente
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant Drinkcard oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Si el índice de la tarjeta coincide con el pageOffset, comienza la animación
    if (widget.index == widget.pageOffset.round()) {
      _controller.forward();
    } else {
      _controller.reset();
    }
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
          AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return buildCupImage(
                    size: size,
                    drink: widget.drink,
                    cardHeight,
                    animationValue: _animation.value);
              }),
          AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return buildBlurImage(
                  cardWidth,
                  cardHeight,
                  drink: widget.drink,
                  size: size,
                  animationValue: _animation.value,
                );
              }),
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
      left: (cardWidth * .0001) + animationValue + 100,
      bottom: cardHeight * 0.80,
      width: 100,
      child: Transform.rotate(
          angle: -.2, child: Image.asset(drink.imageTop.toString())),
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
      width: 80,
      right: (cardWidth * .044) + animationValue - 120,
      top: cardHeight * 0.0009,
      child: Transform.rotate(
        angle: 0.45,
        child: Image.asset(
          drink.imageSmall.toString(),
        ),
      ),
    );
  }
}

class buildBlurImage extends StatelessWidget {
  final Drink drink;
  final Size size;
  final double cardHeight;
  final double cardWidth;
  final double animationValue;

  const buildBlurImage(
    this.cardHeight,
    this.cardWidth, {
    super.key,
    required this.animationValue,
    required this.size,
    required this.drink,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: cardHeight * .25,
      left: cardWidth * 0.05,
      height: cardHeight * 0.30 + animationValue,
      child: Image.asset(drink.imageBlur.toString()),
    );
  }
}

class buildCupImage extends StatelessWidget {
  final Drink drink;
  final Size size;
  final double cardHeight;
  final double animationValue;

  const buildCupImage(this.cardHeight,
      {super.key,
      required this.size,
      required this.drink,
      required this.animationValue});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: cardHeight * 0.60,
      right: (-size.width * .2 / 2) + 35,
      child: Container(
        width: MediaQuery.of(context).size.width * .75,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Image.asset(
              drink.cupImage.toString(),
              height: size.height * .2,
            ),
            Positioned(
              left: MediaQuery.of(context).size.width * .25,
              bottom: 0,
              right: MediaQuery.of(context).size.width * .25,
              child: Transform.rotate(angle: .4, child: Precios()),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width * .09,
              bottom: MediaQuery.of(context).size.width * -.18,
              child: tamanosPizza(drink: drink),
            )
          ],
        ),
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
            Text(
              drink.conName.toString(),
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
                  color: Color.fromARGB(255, 28, 1, 1)),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class tamanosPizza extends StatelessWidget {
  final Drink drink;
  const tamanosPizza({super.key, required this.drink});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(400)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            children: [
              Image.asset(
                drink.cupImage.toString(),
                width: MediaQuery.of(context).size.height * 0.05,
                semanticLabel: 'Imagen de vaso grande',
              ),
              Text('Chica  '),
            ],
          ),
          Column(
            children: [
              Image.asset(
                drink.cupImage.toString(),
                width: MediaQuery.of(context).size.height * 0.08,
                semanticLabel: 'Imagen de vaso mediana',
              ),
              Text('   Mediana  '),
            ],
          ),
          Column(
            children: [
              Image.asset(
                drink.cupImage.toString(),
                width: MediaQuery.of(context).size.height * 0.1,
                semanticLabel: '',
              ),
              Text('Grande'),
            ],
          ),
          const SizedBox(width: 5),
        ],
      ),
    );
  }
}

class Precios extends StatelessWidget {
  const Precios({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: const Color.fromARGB(182, 245, 169, 46),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(3, 3), // Cambia la dirección de la sombra
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(-3, -3), // Añade otra sombra para el efecto 3D
          ),
        ],
      ),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(width: 20),
            Text(
              '\$',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 10),
            Text(
              '4',
              style: TextStyle(
                fontSize: 19,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '.70',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.bold,
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
      top: MediaQuery.of(context).size.height * .1 / 11111111,
      left: MediaQuery.of(context).size.width * .08,
      child: Row(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .09,
            width: MediaQuery.of(context).size.width * .40,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 94, 69, 54),
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(100))),
            child: Text(
              drink.name.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                  color: const Color.fromARGB(213, 246, 4, 4)),
            ),
          ),
          // Text(
          //   drink.conName.toString(),
          //   style: TextStyle(
          //       fontWeight: FontWeight.bold,
          //       fontSize: 50,
          //       color: drink.lightColor),
          // ),
        ],
      ),
    );
  }
}
