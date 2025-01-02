import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:money_management_app/features/profile/presentation/edit_profile/edit_profile_body.dart';
import 'package:money_management_app/utils/constants/strings.dart';

@RoutePage()
class EditProfileScreen extends StatelessWidget {
  final String userName;
  const EditProfileScreen({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(AppStrings.editProfile),
      ),
      body: EditProfileBody(
        userName: userName,
      ),
    );
  }
}
