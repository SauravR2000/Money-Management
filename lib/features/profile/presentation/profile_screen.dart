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

class _ProfileScreenState extends State<ProfileScreen> {
  late GlobalBloc globalBloc;

  // double animatedContainerWidth = 0;

  @override
  void initState() {
    super.initState();

    globalBloc = getIt<GlobalBloc>();

    globalBloc.add(GetUserDetail());
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
                  child: Column(
                    children: [
                      changePassword(context),
                      gap(value: 15),
                      logoutButton(authBloc, context),
                    ],
                  ),
                ),
                gap(value: 15),

                // CustomProgressBar(
                //   progressFraction: 1 / 2,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector changePassword(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.push(ChangePasswordRoute());
      },
      child: Row(
        children: [
          Image.asset("assets/images/setting_icon.png"),
          gap(value: 15),
          Text(
            AppStrings.changePassword,
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(fontWeight: FontWeight.bold),
          )
        ],
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
                      AppStrings.name,
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
