// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:money_management_app/core/network/auth_service.dart' as _i1005;
import 'package:money_management_app/core/storage/local_storage.dart' as _i614;
import 'package:money_management_app/core/storage/secure_local_storage.dart'
    as _i147;
import 'package:money_management_app/features/auth/bloc/auth_bloc/auth_bloc.dart'
    as _i147;
import 'package:money_management_app/features/auth/bloc/check_box_bloc/check_box_bloc.dart'
    as _i215;
import 'package:money_management_app/features/onboarding/cubit/onboarding_check_cubit/onboarding_check_cubit.dart'
    as _i801;
import 'package:money_management_app/features/onboarding/cubit/onboarding_cubit.dart'
    as _i798;
import 'package:money_management_app/features/pincode/cubit/pincode_cubit.dart'
    as _i470;
import 'package:money_management_app/features/transaction/cubit/drop_down/drop_down_cubit_cubit.dart'
    as _i338;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i1005.AuthService>(() => _i1005.AuthService());
    gh.factory<_i215.CheckBoxBloc>(() => _i215.CheckBoxBloc());
    gh.factory<_i801.OnboardingCheckCubit>(() => _i801.OnboardingCheckCubit());
    gh.factory<_i798.OnboardingCubit>(() => _i798.OnboardingCubit());
    gh.factory<_i338.DropDownCubit>(() => _i338.DropDownCubit());
    gh.singleton<_i147.SecureLocalStorage>(() => _i147.SecureLocalStorage());
    gh.singleton<_i614.LocalStorageSharedPref>(
        () => _i614.LocalStorageSharedPref());
    gh.singleton<_i470.PincodeCubit>(() => _i470.PincodeCubit());
    gh.factory<_i147.AuthBloc>(() => _i147.AuthBloc(
          gh<_i1005.AuthService>(),
          gh<_i147.SecureLocalStorage>(),
          gh<_i614.LocalStorageSharedPref>(),
        ));
    return this;
  }
}
