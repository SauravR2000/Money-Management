// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:money_management_app/features/profile/domain/repositories/profile_repository.dart';

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
}
