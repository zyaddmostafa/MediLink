import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../feature/auth/data/repos/auth_repo_impl.dart';
import '../../feature/auth/presentation/cubit/auth_cubit.dart';
import '../api_helpers/api_service.dart';
import '../api_helpers/dio_factory.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  final Dio dio = DioFactory.getDio();

  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));
  getIt.registerLazySingleton<AuthRepoImpl>(() => AuthRepoImpl(getIt()));
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt()));
}
