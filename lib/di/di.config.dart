// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:blood_setu/application/core/auth/auth_controller.dart' as _i839;
import 'package:blood_setu/application/core/services/routing/app_router.dart'
    as _i828;
import 'package:blood_setu/application/core/services/sp_service/sp_service.dart'
    as _i181;
import 'package:blood_setu/application/pages/features/sign_in/bloc/sign_in_bloc.dart'
    as _i18;
import 'package:blood_setu/data/repositories/authentication_repositories_iml.dart'
    as _i310;
import 'package:blood_setu/di/register_module.dart' as _i599;
import 'package:blood_setu/domain/repositories/authentication_repository.dart'
    as _i546;
import 'package:blood_setu/domain/usecase/authentication_usecase.dart' as _i39;
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.singleton<_i59.FirebaseAuth>(() => registerModule.firebaseAuth);
    gh.singleton<_i974.FirebaseFirestore>(() => registerModule.firestore);
    gh.singleton<_i116.GoogleSignIn>(() => registerModule.googleSignIn);
    gh.factory<_i546.AuthenticationRepository>(
      () => _i310.AuthenticationRepositoriesIml(
        gh<_i59.FirebaseAuth>(),
        gh<_i974.FirebaseFirestore>(),
        gh<_i116.GoogleSignIn>(),
      ),
    );
    gh.factory<_i39.AuthenticationUseCase>(
      () => _i39.AuthenticationUseCase(gh<_i546.AuthenticationRepository>()),
    );
    gh.lazySingleton<_i181.SpService>(
      () => _i181.SpServiceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i839.AuthController>(
      () =>
          _i839.AuthController(gh<_i181.SpService>(), gh<_i59.FirebaseAuth>()),
    );
    gh.factory<_i18.SignInBloc>(
      () => _i18.SignInBloc(
        authenticationUseCase: gh<_i39.AuthenticationUseCase>(),
      ),
    );
    gh.factory<_i828.AppRouter>(
      () => _i828.AppRouter(gh<_i839.AuthController>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i599.RegisterModule {}
