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

    userName = event.userName;
    profileImage = event.imageUrl;

    //for state to refresh
    emit(Initial());
    emit(UserDetailStateState());
  }

  _getUserDetail(
    GetUserDetail event,
    Emitter<GlobalState> emit,
  ) async {
    String userId = supabase.auth.currentUser?.id ?? "";
    userName = await _profileRepository.getUserName();
    profileImage = supabase.storage.from('profile_image').getPublicUrl(userId);

    emit(UserDetailStateState());
  }
}
