import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:money_management_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:money_management_app/main.dart';
import 'package:money_management_app/utils/constants/strings.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl extends ProfileRepository {
  @override
  Future getUserName() async {
    var userData = await supabase.auth.getUser();

    log("user meta data = ${userData.user?.userMetadata}");

    return userData.user?.userMetadata?['displayName'] ??
        userData.user?.userMetadata?['full_name'] ??
        AppStrings.noNameFound;
  }
}
