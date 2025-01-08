import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management_app/config/router/app_router.gr.dart';
import 'package:money_management_app/dummy_data.dart';
import 'package:money_management_app/features/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:money_management_app/features/global_bloc/global_bloc.dart';
import 'package:money_management_app/injection/injection_container.dart';
import 'package:money_management_app/shared_widgets/gap_widget.dart';
import 'package:money_management_app/shared_widgets/profile_image.dart';
import 'package:money_management_app/shared_widgets/screen_padding.dart';
import 'package:money_management_app/utils/constants/colors.dart';
import 'package:money_management_app/utils/constants/strings.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late GlobalBloc globalBloc;

  // double animatedContainerWidth = 0;

  final double initialProgressValue = 0.0;

  double animatedContainerWidth = 0.0;
  late AnimationController _controller;
  late Animation<double> _widthAnimation;
  String animationDone = "0";

  @override
  void initState() {
    super.initState();

    globalBloc = getIt<GlobalBloc>();

    globalBloc.add(GetUserDetail());

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _widthAnimation = Tween<double>(begin: 0, end: 0).animate(_controller)
      ..addListener(() {
        setState(() {
          animationDone = _widthAnimation.value.toStringAsFixed(1);
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
    AuthBloc authBloc = getIt<AuthBloc>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: screenPadding(
            child: Column(
              children: [
                userDetailUi(context),
                gap(value: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: logoutButton(authBloc, context),
                ),
                gap(value: 15),
                // SizedBox(
                //   height: 80,
                //   width: MediaQuery.of(context).size.width,
                //   child: Stack(
                //     children: [
                //       Positioned(
                //         top: 10,
                //         left: 0,
                //         child: Container(
                //           height: 10,
                //           width: MediaQuery.of(context).size.width / 1.06,
                //           decoration: BoxDecoration(
                //             color: Colors.grey,
                //             borderRadius: BorderRadius.circular(15),
                //           ),
                //         ),
                //       ),
                //       Positioned(
                //         top: -6,
                //         left: 0,
                //         child: Row(
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             AnimatedContainer(
                //               duration: Duration(seconds: 1),
                //               height: 10,
                //               width: animatedContainerWidth,
                //               decoration: BoxDecoration(
                //                 color: Theme.of(context).primaryColor,
                //                 borderRadius: BorderRadius.circular(15),
                //               ),
                //             ),
                //             Container(
                //               padding: EdgeInsets.symmetric(horizontal: 10),
                //               decoration: BoxDecoration(
                //                 border:
                //                     Border.all(color: Colors.white, width: 10),
                //                 color: AppColors.primaryColor,
                //                 borderRadius: BorderRadius.circular(20),
                //               ),
                //               child: Text(
                //                 animationDone,
                //                 style: Theme.of(context)
                //                     .textTheme
                //                     .bodyMedium!
                //                     .copyWith(color: Colors.white),
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // TextButton(
                //   onPressed: () {
                //     double maxWidthForAnimatedContainer =
                //         MediaQuery.of(context).size.width / 2;
                //     setState(() {
                //       if (animatedContainerWidth == initialProgressValue) {
                //         animatedContainerWidth = maxWidthForAnimatedContainer;

                //         startAnimation(
                //           begin: initialProgressValue,
                //           targetWidth: maxWidthForAnimatedContainer,
                //         );
                //       } else {
                //         animatedContainerWidth = initialProgressValue;

                //         startAnimation(
                //           begin: maxWidthForAnimatedContainer,
                //           targetWidth: initialProgressValue,
                //         );
                //       }
                //     });
                //   },
                //   child: Text("animated container"),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BlocListener<AuthBloc, AuthState> logoutButton(
      AuthBloc authBloc, BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      bloc: authBloc,
      listener: (context, state) {
        if (state is AuthSuccess) {
          context.router.replaceAll([OnboardingRoute()]);
        }
      },
      child: GestureDetector(
        onTap: () {
          authBloc.add(LogoutEvent());
        },
        child: Row(
          children: [
            Image.asset("assets/images/logout.png"),
            gap(value: 15),
            Text(
              AppStrings.logout,
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  Widget userDetailUi(BuildContext context) {
    return BlocBuilder<GlobalBloc, GlobalState>(
      bloc: globalBloc,
      builder: (context, state) {
        log("rebuild the profile UI");
        if (state is UserDetailStateState) {
          var userName = globalBloc.userName ?? "";
          var profileImageUrl = globalBloc.profileImage ?? dummyImage;

          log("profile image from UI = $profileImageUrl");

          return Row(
            children: [
              profileImage(
                context: context,
                imageUrl: profileImageUrl,
              ),
              gap(value: 19),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.userName,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: AppColors.hintTextColor),
                    ),
                    Text(
                      userName,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  context.router.push(EditProfileRoute(userName: userName));
                },
                child: Image.asset("assets/images/edit.png"),
              )
            ],
          );
        } else {
          return CircularProgressIndicator(
            color: Colors.black,
          );
        }
      },
    );
  }
}
