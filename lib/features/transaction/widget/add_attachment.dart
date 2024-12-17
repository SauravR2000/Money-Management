import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:money_management_app/shared_widgets/gap_widget.dart';
import 'package:money_management_app/utils/constants/colors.dart';
import 'package:money_management_app/utils/constants/strings.dart';

class AddAttachmentWidget extends StatelessWidget {
  const AddAttachmentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        show(context: context);
      },
      child: DottedBorder(
        borderType: BorderType.RRect,
        padding: EdgeInsets.all(15),
        color: AppColors.primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/attachment.png"),
            gap(value: 15),
            Text(AppStrings.addAttachment)
          ],
        ),
      ),
    );
  }

  void show({required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: Row(
            children: [
              
            ],
          )
        );
      },
    );
  }
}
