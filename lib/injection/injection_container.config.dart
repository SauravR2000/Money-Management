// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:money_management_app/core/storage/local_storage.dart' as _i614;
import 'package:money_management_app/core/storage/secure_local_storage.dart'
    as _i147;
import 'package:money_management_app/features/auth/bloc/auth_bloc/auth_bloc.dart'
    as _i147;
import 'package:money_management_app/features/auth/bloc/check_box_bloc/check_box_bloc.dart'
    as _i215;
import 'package:money_management_app/core/network/auth_service.dart' as _i691;

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
    gh.factory<_i691.AuthService>(() => _i691.AuthService());
    gh.factory<_i215.CheckBoxBloc>(() => _i215.CheckBoxBloc());
    gh.singleton<_i147.SecureLocalStorage>(() => _i147.SecureLocalStorage());
    gh.singleton<_i614.LocalStorage>(() => _i614.LocalStorage());
    gh.factory<_i147.AuthBloc>(() => _i147.AuthBloc(gh<_i691.AuthService>()));
    return this;
  }
}
