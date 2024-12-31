import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:money_management_app/features/profile/presentation/edit_profile/edit_profile_body.dart';
import 'package:money_management_app/utils/constants/strings.dart';

@RoutePage()
class EditProfileScreen extends StatelessWidget {
  final String imageUrl;
  final String userName;
  const EditProfileScreen({
    super.key,
    required this.imageUrl,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppStrings.editProfile),
      ),
      body: EditProfileBody(
        imageUrl: imageUrl,
        userName: userName,
      ),
    );
  }
}
