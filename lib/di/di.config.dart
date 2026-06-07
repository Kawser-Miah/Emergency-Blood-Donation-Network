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
import 'package:blood_setu/application/pages/features/blood_requests/bloc/blood_requests_bloc.dart'
    as _i340;
import 'package:blood_setu/application/pages/features/bottom_nav/bloc/bottom_nav_bloc.dart'
    as _i619;
import 'package:blood_setu/application/pages/features/create_request/bloc/create_request_bloc.dart'
    as _i879;
import 'package:blood_setu/application/pages/features/donors/bloc/donors_bloc.dart'
    as _i405;
import 'package:blood_setu/application/pages/features/home/bloc/home_bloc.dart'
    as _i579;
import 'package:blood_setu/application/pages/features/registration/bloc/registration_bloc.dart'
    as _i670;
import 'package:blood_setu/application/pages/features/sign_in/bloc/sign_in_bloc.dart'
    as _i18;
import 'package:blood_setu/data/repositories/authentication_repositories_iml.dart'
    as _i310;
import 'package:blood_setu/data/repositories/blood_request_repository_impl.dart'
    as _i811;
import 'package:blood_setu/data/repositories/donation_repository_impl.dart'
    as _i76;
import 'package:blood_setu/data/repositories/location_repository_impl.dart'
    as _i470;
import 'package:blood_setu/data/repositories/nearby_donors_repository_impl.dart'
    as _i364;
import 'package:blood_setu/data/repositories/registration_repository_iml.dart'
    as _i916;
import 'package:blood_setu/di/register_module.dart' as _i599;
import 'package:blood_setu/domain/repositories/authentication_repository.dart'
    as _i546;
import 'package:blood_setu/domain/repositories/blood_request_repository.dart'
    as _i3;
import 'package:blood_setu/domain/repositories/donation_repository.dart'
    as _i133;
import 'package:blood_setu/domain/repositories/location_repository.dart'
    as _i766;
import 'package:blood_setu/domain/repositories/nearby_donors_repository.dart'
    as _i377;
import 'package:blood_setu/domain/repositories/registration_repository.dart'
    as _i268;
import 'package:blood_setu/domain/usecase/authentication_usecase.dart' as _i39;
import 'package:blood_setu/domain/usecase/blood_requests_usecase.dart' as _i269;
import 'package:blood_setu/domain/usecase/create_request_usecase.dart' as _i309;
import 'package:blood_setu/domain/usecase/donation_usecase.dart' as _i141;
import 'package:blood_setu/domain/usecase/location_usecase.dart' as _i1060;
import 'package:blood_setu/domain/usecase/nearby_donors_usecase.dart' as _i859;
import 'package:blood_setu/domain/usecase/registration_user_usecase.dart'
    as _i881;
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
    gh.factory<_i619.BottomNavBloc>(() => _i619.BottomNavBloc());
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.singleton<_i59.FirebaseAuth>(() => registerModule.firebaseAuth);
    gh.singleton<_i974.FirebaseFirestore>(() => registerModule.firestore);
    gh.singleton<_i116.GoogleSignIn>(() => registerModule.googleSignIn);
    gh.factory<_i268.RegistrationRepository>(
      () => _i916.RegistrationRepositoryIml(
        gh<_i59.FirebaseAuth>(),
        gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.factory<_i377.NearbyDonorsRepository>(
      () => _i364.NearbyDonorsRepositoryImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i181.SpService>(
      () => _i181.SpServiceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i133.DonationRepository>(
      () => _i76.DonationRepositoryImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.factory<_i141.DonationUseCase>(
      () => _i141.DonationUseCase(gh<_i133.DonationRepository>()),
    );
    gh.factory<_i881.RegistrationUserUseCase>(
      () => _i881.RegistrationUserUseCase(gh<_i268.RegistrationRepository>()),
    );
    gh.lazySingleton<_i839.AuthController>(
      () =>
          _i839.AuthController(gh<_i181.SpService>(), gh<_i59.FirebaseAuth>()),
    );
    gh.factory<_i3.BloodRequestRepository>(
      () => _i811.BloodRequestRepositoryImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.factory<_i766.LocationRepository>(
      () => _i470.LocationRepositoryImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.factory<_i546.AuthenticationRepository>(
      () => _i310.AuthenticationRepositoriesIml(
        gh<_i59.FirebaseAuth>(),
        gh<_i974.FirebaseFirestore>(),
        gh<_i116.GoogleSignIn>(),
        gh<_i181.SpService>(),
      ),
    );
    gh.factory<_i309.CreateRequestUseCase>(
      () => _i309.CreateRequestUseCase(gh<_i3.BloodRequestRepository>()),
    );
    gh.factory<_i670.RegistrationBloc>(
      () => _i670.RegistrationBloc(gh<_i881.RegistrationUserUseCase>()),
    );
    gh.lazySingleton<_i828.AppRouter>(
      () => _i828.AppRouter(gh<_i839.AuthController>()),
    );
    gh.factory<_i39.AuthenticationUseCase>(
      () => _i39.AuthenticationUseCase(gh<_i546.AuthenticationRepository>()),
    );
    gh.factory<_i859.NearbyDonorsUseCase>(
      () => _i859.NearbyDonorsUseCase(gh<_i377.NearbyDonorsRepository>()),
    );
    gh.factory<_i269.BloodRequestsUseCase>(
      () => _i269.BloodRequestsUseCase(gh<_i3.BloodRequestRepository>()),
    );
    gh.factory<_i1060.LocationUseCase>(
      () => _i1060.LocationUseCase(gh<_i766.LocationRepository>()),
    );
    gh.factory<_i579.HomeBloc>(
      () => _i579.HomeBloc(
        gh<_i881.RegistrationUserUseCase>(),
        gh<_i1060.LocationUseCase>(),
        gh<_i859.NearbyDonorsUseCase>(),
      ),
    );
    gh.factory<_i340.BloodRequestsBloc>(
      () => _i340.BloodRequestsBloc(
        gh<_i269.BloodRequestsUseCase>(),
        gh<_i1060.LocationUseCase>(),
      ),
    );
    gh.factory<_i405.DonorsBloc>(
      () => _i405.DonorsBloc(
        gh<_i859.NearbyDonorsUseCase>(),
        gh<_i181.SpService>(),
      ),
    );
    gh.factory<_i18.SignInBloc>(
      () => _i18.SignInBloc(
        authenticationUseCase: gh<_i39.AuthenticationUseCase>(),
      ),
    );
    gh.factory<_i879.CreateRequestBloc>(
      () => _i879.CreateRequestBloc(
        gh<_i309.CreateRequestUseCase>(),
        gh<_i1060.LocationUseCase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i599.RegisterModule {}
