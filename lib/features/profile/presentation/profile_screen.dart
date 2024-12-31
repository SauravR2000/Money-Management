import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management_app/config/router/app_router.gr.dart';
import 'package:money_management_app/dummy_data.dart';
import 'package:money_management_app/features/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:money_management_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:money_management_app/injection/injection_container.dart';
import 'package:money_management_app/main.dart';
import 'package:money_management_app/shared_widgets/gap_widget.dart';
import 'package:money_management_app/shared_widgets/profile_image.dart';
import 'package:money_management_app/shared_widgets/screen_padding.dart';
import 'package:money_management_app/utils/constants/colors.dart';
import 'package:money_management_app/utils/constants/strings.dart';

@RoutePage()
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

  Widget userDetailUi(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileCubit>()..getUser(),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is UserNameState) {
            var userName = state.userName;
            String userId = supabase.auth.currentUser?.id ?? "";
            final profileImageUrl =
                supabase.storage.from('profile_image').getPublicUrl(userId);

            return Row(
              children: [
                profileImage(context: context, imageUrl: profileImageUrl),
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
                    Text(
                      userName,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    context.router.push(EditProfileRoute(
                        imageUrl: dummyImage, userName: userName));
                  },
                  child: Image.asset("assets/images/edit.png"),
                )
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
