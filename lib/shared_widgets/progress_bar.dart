import 'package:flutter/material.dart';
import 'package:money_management_app/utils/constants/colors.dart';

class CustomProgressBar extends StatefulWidget {
  final double progressFraction;
  const CustomProgressBar({
    super.key,
    required this.progressFraction,
  });

  @override
  State<CustomProgressBar> createState() => _CustomProgressBarState();
}

class _CustomProgressBarState extends State<CustomProgressBar>
    with SingleTickerProviderStateMixin {
  final double initialProgressValue = 0.0;

  double animatedContainerWidth = 0.0;
  late AnimationController _controller;
  late Animation<double> _widthAnimation;
  String animationDone = "0";

  @override
  void initState() {
    super.initState();

    //initialize controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    //initializer listener for animating text
    _widthAnimation = Tween<double>(begin: 0, end: 0).animate(_controller)
      ..addListener(() {
        setState(() {
          animationDone = _widthAnimation.value.toStringAsFixed(1);
        });
      });

    double maxWidthForAnimatedContainer = 100;

    giveWidthValue();

    startAnimation(
      begin: initialProgressValue,
      targetWidth: maxWidthForAnimatedContainer,
    );
  }

  giveWidthValue() {
    Duration(seconds: 10);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        animatedContainerWidth =
            MediaQuery.of(context).size.width * widget.progressFraction;
      });
    });
  }

  void startAnimation({
    required double targetWidth,
    required double begin,
  }) {
    _widthAnimation = Tween<double>(
      begin: begin,
      end: targetWidth,
    ).animate(_controller);

    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 80,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                top: 10,
                left: 0,
                child: Container(
                  height: 10,
                  width: MediaQuery.of(context).size.width / 1.06,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              Positioned(
                top: -6,
                left: 0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      duration: Duration(seconds: 1),
                      height: 10,
                      width: animatedContainerWidth,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 10),
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        animationDone,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            double maxWidthForAnimatedContainer =
                MediaQuery.of(context).size.width / 2;
            setState(() {
              if (animatedContainerWidth == initialProgressValue) {
                animatedContainerWidth = maxWidthForAnimatedContainer;

                startAnimation(
                  begin: initialProgressValue,
                  targetWidth: maxWidthForAnimatedContainer,
                );
              } else {
                animatedContainerWidth = initialProgressValue;

                startAnimation(
                  begin: maxWidthForAnimatedContainer,
                  targetWidth: initialProgressValue,
                );
              }
            });
          },
          child: Text("animated container"),
        ),
      ],
    );
  }
}
