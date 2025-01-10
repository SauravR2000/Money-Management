import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:money_management_app/config/router/app_router.gr.dart';
import 'package:money_management_app/features/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:money_management_app/injection/injection_container.dart';
import 'package:money_management_app/main.dart';
import 'package:money_management_app/shared_widgets/gap_widget.dart';
import 'package:money_management_app/utils/constants/colors.dart';
import 'package:money_management_app/utils/constants/strings.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginWithGoogleWidget extends StatefulWidget {
  const LoginWithGoogleWidget({super.key});

  @override
  State<LoginWithGoogleWidget> createState() => _LoginWithGoogleWidgetState();
}

class _LoginWithGoogleWidgetState extends State<LoginWithGoogleWidget> {
  @override
  void initState() {
    super.initState();
    _setupAuthListener();
  }

  void _setupAuthListener() {
    supabase.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      log("supabase event = $event");
      if (event == AuthChangeEvent.signedIn) {
        if (mounted) {
          // Navigator.of(context).pushReplacement(
          //   MaterialPageRoute(
          //     builder: (context) => const DashboardScreen(),
          //   ),
          // );

          context.router.replaceAll([DashboardRoute()]);
        }
      }
    });
  }

  Future<AuthResponse> _googleSignIn() async {
    String webClientId = dotenv.env['WEB_CLIENT_ID'] ?? "";

    String iosClientId = dotenv.env['IOS_CLIENT_ID'] ?? "";

    log("iosClientId = $iosClientId");

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();

    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    return supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: GestureDetector(
        onTap: () async {
          var response = await _googleSignIn();

          getIt<AuthBloc>().storeUserCredentials(response);
        },
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              width: 1,
              color: AppColors.hintTextColor,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/google_icon.png"),
              gap(value: 10),
              Text(
                AppStrings.signupWithGoogle,
                style: textTheme.bodyMedium!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
