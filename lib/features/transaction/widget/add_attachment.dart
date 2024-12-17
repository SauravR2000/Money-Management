import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management_app/features/transaction/cubit/add_attachment/add_attachment_cubit.dart';
import 'package:money_management_app/injection/injection_container.dart';
import 'package:money_management_app/shared_widgets/gap_widget.dart';
import 'package:money_management_app/utils/constants/colors.dart';
import 'package:money_management_app/utils/constants/enums.dart';
import 'package:money_management_app/utils/constants/strings.dart';

class AddAttachmentWidget extends StatelessWidget {
  const AddAttachmentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AddAttachmentCubit addAttachmentCubit = getIt<AddAttachmentCubit>();

    return BlocBuilder<AddAttachmentCubit, AddAttachmentState>(
      bloc: addAttachmentCubit,
      builder: (context, state) {
        bool isImageAvailable = addAttachmentCubit.image != null;

        return isImageAvailable
            ? Stack(
                children: [
                  Container(
                    height: 112,
                    width: 112,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.file(
                      File(addAttachmentCubit.image!.path),
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    right: 8, // Adjust position from right
                    top: 16, // Adjust position from top
                    child: GestureDetector(
                      onTap: () {
                        addAttachmentCubit.removeImage();
                      },
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.black
                              .withOpacity(0.4), // Semi-transparent black color
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : GestureDetector(
                onTap: () {
                  show(
                    context: context,
                    addAttachmentCubit: addAttachmentCubit,
                  );
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
      },
    );
  }

  void show({
    required BuildContext context,
    required AddAttachmentCubit addAttachmentCubit,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              optionUi(
                context: context,
                imageAsset: "assets/images/camera.png",
                title: AppStrings.camera,
                onTap: () async {
                  addAttachmentCubit.setImage(
                    imageCaptureType: ImageCaptureType.camera,
                  );
                },
              ),
              gap(value: 15),
              optionUi(
                context: context,
                imageAsset: "assets/images/gallery.png",
                title: AppStrings.image,
                onTap: () {
                  addAttachmentCubit.setImage(
                    imageCaptureType: ImageCaptureType.gallery,
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }

  Widget optionUi({
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
}
