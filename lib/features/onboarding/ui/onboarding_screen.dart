import 'package:money_management_app/config/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management_app/features/data/onboarding_items.dart';
import 'package:money_management_app/features/onboarding/cubit/onboarding_cubit.dart';

int currentPageIndex = 0;

buildCarouselIndicator(
  int currentPage,
  OnboardingCubit onboardingCubit,
) {
  return BlocBuilder<OnboardingCubit, OnboardingState>(
    bloc: onboardingCubit,
    builder: (context, state) {
      currentPage = onboardingCubit.page;

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < onboardingItems.length; i++)
            Container(
              margin: const EdgeInsets.all(5),
              height: i == currentPage ? 15 : 8,
              width: i == currentPage ? 15 : 8,
              decoration: BoxDecoration(
                color: i == currentPage
                    ? const Color.fromARGB(255, 127, 61, 255)
                    : const Color.fromARGB(255, 238, 229, 255),
                shape: BoxShape.circle,
              ),
            )
        ],
      );
    },
  );
}

@RoutePage()
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingState();
}

class _OnboardingState extends State<OnboardingScreen> {
  final CarouselSliderController carouselSliderController =
      CarouselSliderController();

  late OnboardingCubit _onboardingCubit;

  @override
  void initState() {
    super.initState();
    _onboardingCubit = OnboardingCubit();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OnboardingCubit>(
      create: (BuildContext context) => _onboardingCubit,
      child: BlocListener<OnboardingCubit, OnboardingState>(
        listener: (context, state) => switch (state) {
          OnboardingInitial() => throw UnimplementedError(),
          OnboardingCarouselPageChanged() => currentPageIndex =
              state.currentValue,
        },
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  CarouselSlider(
                    items: onboardingItems
                        .map(
                          (item) => Center(
                            child: Column(
                              children: [
                                const SizedBox(height: 32),
                                Image.asset(
                                  item.image,
                                  height: 290,
                                  // width: 290.w,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(height: 41),
                                Text(
                                  item.title,
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                  textAlign: TextAlign.center,
                                  // maxLines: 1,
                                ),
                                const SizedBox(height: 16),
                                Expanded(
                                  child: Text(
                                    item.body,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                    options: CarouselOptions(
                      // height: 486.h,
                      autoPlay: false,
                      aspectRatio: 450 / 630,
                      viewportFraction: 1.0,
                      enlargeCenterPage: false,
                      enableInfiniteScroll: false,
                      onPageChanged: (value, _) {
                        // context.read<OnboardingCubit>().pageChanged(value);
                        _onboardingCubit.pageChanged(value);
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  buildCarouselIndicator(currentPageIndex, _onboardingCubit),
                  const SizedBox(height: 33),
                  SizedBox(
                    width: 323,
                    height: 56,
                    child: ElevatedButton(
                      style: Theme.of(context).elevatedButtonTheme.style,
                      onPressed: () {
                        context.router.push(const SignupRoute());
                      },
                      child: const Text('Sign Up'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 56,
                    width: 323,
                    child: ElevatedButton(
                      style:
                          Theme.of(context).elevatedButtonTheme.style?.copyWith(
                                backgroundColor: WidgetStateProperty.all(
                                    const Color.fromARGB(255, 238, 229, 255)),
                              ),
                      onPressed: () {
                        context.router.push(const LoginRoute());
                      },
                      child: Text(
                        'Login',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(
                                color: const Color.fromARGB(255, 127, 61, 255)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
