import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../feature/auth/data/apis/auth_api_service.dart';
import '../../feature/auth/data/repos/auth_repo_impl.dart';
import '../../feature/auth/presentation/cubit/auth_cubit.dart';
import '../../feature/booking/data/apis/booking_appointment_api_service.dart';
import '../../feature/booking/data/local/cancle_appoinmets_local_service.dart';
import '../../feature/booking/data/repo/booking_appointment_repo.dart';
import '../../feature/booking/domain/use_case/filtered_appointment_use_case.dart';
import '../../feature/booking/presentation/cubit/booking_appointment_cubit.dart';
import '../../feature/home/data/apis/home_api_service.dart';
import '../../feature/home/data/repo/home_repo_impl.dart';
import '../../feature/home/presentation/cubit/home_cubit.dart';
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
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt()));

  // store appointment dependencies
  getIt.registerLazySingleton<BookingAppointmentApiService>(
    () => BookingAppointmentApiService(dio),
  );
  getIt.registerLazySingleton<CancelledAppointmentsLocalService>(
    () => CancelledAppointmentsLocalService(),
  );
  getIt.registerLazySingleton<BookingAppointmentRepo>(
    () => BookingAppointmentRepo(getIt(), getIt()),
  );
  getIt.registerLazySingleton<FilteredAppointmentUseCase>(
    () => FilteredAppointmentUseCase(getIt(), getIt()),
  );
}
