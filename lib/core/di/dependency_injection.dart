import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../feature/auth/data/apis/auth_api_service.dart';
import '../../feature/auth/data/repos/auth_repo_impl.dart';
import '../../feature/auth/presentation/cubit/auth_cubit.dart';
import '../../feature/checkout/data/apis/store_appointment_api_service.dart';
import '../../feature/checkout/data/repo/store_appointment_repo.dart';
import '../../feature/home/data/apis/home_api_service.dart';
import '../../feature/home/data/repo/home_repo_impl.dart';
import '../api_helpers/dio_factory.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  final Dio dio = DioFactory.getDio();

  getIt.registerLazySingleton<AuthApiService>(() => AuthApiService(dio));
  // Authentication related dependencies
  getIt.registerLazySingleton<AuthRepoImpl>(() => AuthRepoImpl(getIt()));
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt()));

  // Home related dependencies
  getIt.registerLazySingleton<HomeApiService>(() => HomeApiService(dio));
  getIt.registerLazySingleton<HomeRepoImpl>(() => HomeRepoImpl(getIt()));

  // store appointment dependencies
  getIt.registerLazySingleton<StoreAppointmentApiService>(
    () => StoreAppointmentApiService(dio),
  );
  getIt.registerLazySingleton<StoreAppointmentRepo>(
    () => StoreAppointmentRepo(getIt()),
  );
}
