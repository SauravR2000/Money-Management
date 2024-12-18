import 'dart:math';

import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatefulWidget {
  const CustomFloatingActionButton({super.key});

  @override
  State<CustomFloatingActionButton> createState() =>
      _CustomFloatingActionButtonState();
}

bool toggle = true;

class _CustomFloatingActionButtonState extends State<CustomFloatingActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  Alignment alignment1 = Alignment(0, 0);
  Alignment alignment2 = Alignment(0, 0);
  Alignment alignment3 = Alignment(0, 0);

  double size1 = 50;
  double size2 = 50;
  double size3 = 50;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 350),
      reverseDuration: Duration(milliseconds: 275),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    );
    _animationController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 250,
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 115),
        child: Stack(
          children: [
            AnimatedAlign(
              duration: toggle
                  ? Duration(milliseconds: 275)
                  : Duration(milliseconds: 875),
              alignment: alignment1,
              curve: toggle ? Curves.easeIn : Curves.elasticOut,
              child: AnimatedContainer(
                padding: EdgeInsets.only(bottom: 4),
                duration: Duration(milliseconds: 275),
                curve: toggle ? Curves.easeIn : Curves.easeOut,
                height: size1,
                width: size1,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 0, 168, 107),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    'assets/images/income.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            AnimatedAlign(
              duration: toggle
                  ? Duration(milliseconds: 275)
                  : Duration(milliseconds: 875),
              alignment: alignment2,
              curve: toggle ? Curves.easeIn : Curves.elasticOut,
              child: AnimatedContainer(
                padding: EdgeInsets.all(6),
                duration: Duration(milliseconds: 275),
                curve: toggle ? Curves.easeIn : Curves.easeOut,
                height: size2,
                width: size2,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 0, 119, 255),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    'assets/images/currency_exchange.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            AnimatedAlign(
              duration: toggle
                  ? Duration(milliseconds: 275)
                  : Duration(milliseconds: 875),
              alignment: alignment3,
              curve: toggle ? Curves.easeIn : Curves.elasticOut,
              child: AnimatedContainer(
                padding: EdgeInsets.only(bottom: 4),
                duration: Duration(milliseconds: 275),
                curve: toggle ? Curves.easeIn : Curves.easeOut,
                height: size3,
                width: size3,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 253, 61, 74),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    'assets/images/expense.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Align(
              child: Transform.rotate(
                angle: _animation.value * pi * (3 / 4),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 375),
                  curve: Curves.easeOut,
                  height: toggle ? 60 : 50,
                  width: toggle ? 60 : 50,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      splashColor: Colors.white54,
                      splashRadius: 31,
                      onPressed: () {
                        setState(
                          () {
                            if (toggle) {
                              toggle = !toggle;
                              _animationController.forward();
                              Future.delayed(
                                Duration(milliseconds: 10),
                                () {
                                  alignment1 = Alignment(-0.7, -0.9);
                                },
                              );
                              Future.delayed(
                                Duration(milliseconds: 100),
                                () {
                                  alignment2 = Alignment(0.0, -2.2);
                                },
                              );
                              Future.delayed(
                                Duration(milliseconds: 200),
                                () {
                                  alignment3 = Alignment(0.7, -0.9);
                                },
                              );
                            } else {
                              toggle = !toggle;
                              _animationController.reverse();
                              alignment1 = Alignment(0, 0);
                              alignment2 = Alignment(0, 0);
                              alignment3 = Alignment(0, 0);
                            }
                          },
                        );
                      },
                      icon: Icon(
                        Icons.add,
                        size: 30,
                        color: Colors.white,
                      ),
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
