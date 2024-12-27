import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management_app/config/router/app_router.gr.dart';
import 'package:money_management_app/dummy_data.dart';
import 'package:money_management_app/features/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:money_management_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:money_management_app/injection/injection_container.dart';
import 'package:money_management_app/shared_widgets/gap_widget.dart';
import 'package:money_management_app/shared_widgets/screen_padding.dart';
import 'package:money_management_app/utils/constants/colors.dart';
import 'package:money_management_app/utils/constants/strings.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
                )
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

  Row userDetailUi(BuildContext context) {
    return Row(
      children: [
        profileImage(context),
        gap(value: 19),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.userName,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColors.hintTextColor),
            ),
            BlocProvider(
              create: (context) => getIt<ProfileCubit>()..getUser(),
              child: BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  if (state is UserNameState) {
                    var userName = state.userName;

                    return Text(
                      userName,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(fontWeight: FontWeight.w600),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        )
      ],
    );
  }

  Container profileImage(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 2,
        ),
      ),
      child: ClipOval(
        child: Image.network(
          dummyImage,
          fit: BoxFit.cover,
          width: 80,
          height: 80,
        ),
      ),
    );
  }
}
