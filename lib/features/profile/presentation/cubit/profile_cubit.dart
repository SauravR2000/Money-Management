// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:money_management_app/features/global_bloc/global_bloc.dart';

import 'package:money_management_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:money_management_app/helper/get_file_extension.dart';
import 'package:money_management_app/injection/injection_container.dart';
import 'package:money_management_app/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'profile_cubit.freezed.dart';
part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _profileRepository;
  ProfileCubit(
    this._profileRepository,
  ) : super(ProfileState.initial());

//get user detail
  Future<void> getUser() async {
    String userName = await _profileRepository.getUserName();
    emit(UserNameState(userName: userName));
  }

  Future<String> uploadProfileImage({required XFile file}) async {
    final fileExtension = getFileExtension(xfile: file);
    final imageBytes = await file.readAsBytes();
    final userId = supabase.auth.currentUser!.id;
    String imageId = await supabase.storage.from('profile_image').uploadBinary(
          '/$userId',
          imageBytes,
          fileOptions: FileOptions(
            upsert: true,
            contentType: 'image/$fileExtension',
          ),
        );

    log("image id = $imageId");

    var imageUrl = supabase.storage.from('profile_image').getPublicUrl(imageId);

    log("image url = $imageUrl");

    return imageId;
  }

  Future editProfile({
    XFile? newProfileImage,
    String? userName,
  }) async {
    emit(ProfileLoadingState());

    try {
      String? imageId;
      if (newProfileImage != null) {
        imageId = await uploadProfileImage(file: newProfileImage);
      }

      if (imageId != null) {
        await supabase.auth.updateUser(
          UserAttributes(data: {
            'profile_image_url': imageId,
          }),
        );
      }

      if (userName != null) {
        await supabase.auth.updateUser(
          UserAttributes(
            data: {
              'displayName': userName,
            },
          ),
        );
      }

      emit(ProfileUpdatedSuccessState());

      GlobalBloc globalBloc = getIt<GlobalBloc>();
      globalBloc.add(UpdateUserDetail(userName: userName, imageId: imageId));
    } catch (e) {
      emit(ProfileErrorState(error: e.toString()));
    }
  }
}
