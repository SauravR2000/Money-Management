import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management_app/features/transaction/cubit/add_attachment/add_attachment_cubit.dart';
import 'package:money_management_app/shared_widgets/attachment_option_widget.dart';
import 'package:money_management_app/shared_widgets/close_icon_widget.dart';
import 'package:money_management_app/shared_widgets/gap_widget.dart';
import 'package:money_management_app/utils/constants/colors.dart';
import 'package:money_management_app/utils/constants/enums.dart';
import 'package:money_management_app/utils/constants/strings.dart';
import 'package:path/path.dart' as path;

class AddAttachmentWidget extends StatelessWidget {
  final AddAttachmentCubit addAttachmentCubit;
  const AddAttachmentWidget({
    super.key,
    required this.addAttachmentCubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddAttachmentCubit, AddAttachmentState>(
      bloc: addAttachmentCubit,
      builder: (context, state) {
        bool isImageAvailable = addAttachmentCubit.image != null;
        bool isPdfFileAvailable = addAttachmentCubit.pdf != null;

        return isImageAvailable
            ? imagePreview()
            : isPdfFileAvailable
                ? pdfPreview()
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

  Container pdfPreview() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.hintTextColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                path.basename(
                  addAttachmentCubit.pdf!.toString(),
                ),
                maxLines: 1,
              ),
            ),
          ),
          gap(value: 15),
          InkWell(
            onTap: () {
              addAttachmentCubit.remotePdf();
            },
            child: CloseIconWidget(),
          ),
        ],
      ),
    );
  }

  Stack imagePreview() {
    return Stack(
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
            child: CloseIconWidget(),
          ),
        ),
      ],
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
              attachmentOptionUi(
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
              attachmentOptionUi(
                context: context,
                imageAsset: "assets/images/gallery.png",
                title: AppStrings.image,
                onTap: () {
                  addAttachmentCubit.setImage(
                    imageCaptureType: ImageCaptureType.gallery,
                  );
                },
              ),
              gap(value: 15),
              attachmentOptionUi(
                context: context,
                imageAsset: "assets/images/file.png",
                title: AppStrings.document,
                onTap: () {
                  addAttachmentCubit.setPdf();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
