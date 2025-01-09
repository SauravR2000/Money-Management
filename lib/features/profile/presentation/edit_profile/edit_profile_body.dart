import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:money_management_app/dummy_data.dart';
import 'package:money_management_app/features/global_bloc/global_bloc.dart';
import 'package:money_management_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:money_management_app/features/transaction/cubit/add_attachment/add_attachment_cubit.dart';
import 'package:money_management_app/injection/injection_container.dart';
import 'package:money_management_app/main.dart';
import 'package:money_management_app/shared_widgets/attachment_option_widget.dart';
import 'package:money_management_app/shared_widgets/custom_button.dart';
import 'package:money_management_app/shared_widgets/custom_text_from_field.dart';
import 'package:money_management_app/shared_widgets/gap_widget.dart';
import 'package:money_management_app/shared_widgets/profile_image.dart';
import 'package:money_management_app/shared_widgets/screen_padding.dart';
import 'package:money_management_app/shared_widgets/unfocus_screen_widget.dart';
import 'package:money_management_app/utils/constants/enums.dart';
import 'package:money_management_app/utils/constants/strings.dart';

class EditProfileBody extends StatefulWidget {
  final String userName;
  const EditProfileBody({
    super.key,
    required this.userName,
  });

  @override
  State<EditProfileBody> createState() => _EditProfileBodyState();
}

class _EditProfileBodyState extends State<EditProfileBody> {
  late AddAttachmentCubit _addAttachmentCubit;
  late ProfileCubit _profileCubit;

  late TextEditingController _emailController;
  late TextEditingController _userNameController;
  late String profileImageUrl;

  @override
  void initState() {
    super.initState();
    _addAttachmentCubit = getIt<AddAttachmentCubit>();
    _profileCubit = getIt<ProfileCubit>();

    // String userId = supabase.auth.currentUser?.id ?? "";
    profileImageUrl = getIt<GlobalBloc>().profileImage ?? dummyImage;
    String email = supabase.auth.currentUser?.email ?? "email not found";
    _emailController = TextEditingController(text: email);
    _userNameController = TextEditingController(text: widget.userName);
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _userNameController.dispose();

    _addAttachmentCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: UnfocusScreenWidget(
        child: screenPadding(
          child: Column(
            children: [
              userProfileImageWidget(context),
              gap(value: 35),
              CustomTextFormField(
                controller: _emailController,
                labelText: AppStrings.email,
                readOnly: true,
              ),
              gap(value: 20),
              CustomTextFormField(
                controller: _userNameController,
                labelText: AppStrings.name,
              ),
              gap(value: 80),
              SizedBox(
                width: double.maxFinite,
                child: BlocConsumer<ProfileCubit, ProfileState>(
                  bloc: _profileCubit,
                  listener: (context, state) {
                    if (state is ProfileUpdatedSuccessState) {
                      context.router.popForced();

                      Fluttertoast.showToast(
                        msg: AppStrings.profileUpdated,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }
                  },
                  builder: (context, state) {
                    return CustomButton(
                      text: AppStrings.update,
                      onPressed: () {
                        String enteredText = _userNameController.text;
                        if (enteredText != widget.userName ||
                            _addAttachmentCubit.image != null) {
                          _profileCubit.editProfile(
                            newProfileImage: _addAttachmentCubit.image,
                            userName: enteredText == widget.userName
                                ? null
                                : enteredText,
                          );
                        } else {
                          Fluttertoast.showToast(
                            msg: "User detail not edited",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.yellow,
                            textColor: Colors.black,
                            fontSize: 16.0,
                          );
                        }
                      },
                      isLoading: state is ProfileLoadingState,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget userProfileImageWidget(BuildContext context) {
    return BlocBuilder<AddAttachmentCubit, AddAttachmentState>(
      bloc: _addAttachmentCubit,
      builder: (context, state) {
        return InkWell(
          onTap: () {
            show(
              context: context,
              addAttachmentCubit: _addAttachmentCubit,
            );
          },
          child: Center(
            child: Stack(
              children: [
                profileImage(
                  context: context,
                  imageUrl: profileImageUrl,
                  imageFromFilePath: _addAttachmentCubit.image?.path,
                ),
                Positioned(
                  bottom: -3,
                  right: -5,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Icon(Icons.edit),
                  ),
                ),
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
            ],
          ),
        );
      },
    );
  }
}
