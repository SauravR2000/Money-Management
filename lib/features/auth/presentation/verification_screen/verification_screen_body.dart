import 'package:flutter/material.dart';
import 'package:money_management_app/shared_widgets/screen_padding.dart';
import 'package:money_management_app/shared_widgets/unfocus_screen_widget.dart';
import 'package:money_management_app/utils/constants/strings.dart';

class VerificationScreenBody extends StatefulWidget {
  const VerificationScreenBody({super.key});

  @override
  State<VerificationScreenBody> createState() => _VerificationScreenBodyState();
}

class _VerificationScreenBodyState extends State<VerificationScreenBody> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return UnfocusScreenWidget(
      child: screenPadding(
        child: ListView(
          shrinkWrap: true,
          children: [
            Text(
              AppStrings.enterVerificationCode,
              style: textTheme.headlineLarge,
            )
          ],
        ),
      ),
    );
  }
}
