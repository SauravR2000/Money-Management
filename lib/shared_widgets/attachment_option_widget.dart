  import 'package:flutter/material.dart';
import 'package:money_management_app/shared_widgets/gap_widget.dart';
import 'package:money_management_app/utils/constants/colors.dart';

Widget attachmentOptionUi({
    required BuildContext context,
    required String imageAsset,
    required String title,
    required void Function() onTap,
  }) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.violetColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(imageAsset),
            gap(value: 5),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: AppColors.primaryColor),
            )
          ],
        ),
      ),
    );
  }