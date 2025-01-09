import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:money_management_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:money_management_app/main.dart';

part 'global_event.dart';
part 'global_state.dart';
part 'global_bloc.freezed.dart';

@singleton
class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  final ProfileRepository _profileRepository;

  String? userName;
  String? profileImage;

  GlobalBloc(this._profileRepository) : super(Initial()) {
    on<GlobalEvent>((event, emit) {});
    on<UpdateUserDetail>(_updateUserDetail);
    on<GetUserDetail>(_getUserDetail);
  }

  _updateUserDetail(
    UpdateUserDetail event,
    Emitter<GlobalState> emit,
  ) {
    log("prev data = $userName $profileImage");

    log("image id in global bloc = ${event.imageId}");

    if (event.userName != null) userName = event.userName;
    if (event.imageId != null) {
      String userId = supabase.auth.currentUser?.id ?? "";
      String imageUrl =
          supabase.storage.from('profile_image').getPublicUrl(userId);
      profileImage = imageUrl;

      log("profile image url ==== $profileImage");
    }

    //for state to refresh
    emit(Initial());
    emit(UserDetailStateState());
  }

  _getUserDetail(
    GetUserDetail event,
    Emitter<GlobalState> emit,
  ) async {
    var userData = await supabase.auth.getUser();

    String userId = supabase.auth.currentUser?.id ?? "";
    userName = await _profileRepository.getUserName();
    profileImage = userData.user?.userMetadata?['avatar_url'] ??
        supabase.storage.from('profile_image').getPublicUrl(userId);

    log("get user detail = $profileImage");

    emit(UserDetailStateState());
  }
}
