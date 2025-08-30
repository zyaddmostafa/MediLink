import 'package:bloc_test/bloc_test.dart';
import 'package:doctor_appoinment/core/api_helpers/api_result.dart';
import 'package:doctor_appoinment/feature/home/data/model/doctor_model.dart';
import 'package:doctor_appoinment/feature/home/domain/usecases/base_use_case.dart';
import 'package:doctor_appoinment/feature/home/domain/usecases/get_all_doctors_use_case.dart';
import 'package:doctor_appoinment/feature/home/domain/usecases/get_doctor_by_id_use_case.dart';
import 'package:doctor_appoinment/feature/home/domain/usecases/get_doctors_by_category_use_case.dart';
import 'package:doctor_appoinment/feature/home/domain/usecases/search_doctors_use_case.dart';
import 'package:doctor_appoinment/feature/home/domain/usecases/toggle_favorite_use_case.dart';
import 'package:doctor_appoinment/feature/home/presentation/cubit/home_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetAllDoctorsUseCase extends Mock implements GetAllDoctorsUseCase {}

class MockGetDoctorByIdUseCase extends Mock implements GetDoctorByIdUseCase {}

class MockSearchDoctorsUseCase extends Mock implements SearchDoctorsUseCase {}

class MockToggleFavoriteUseCase extends Mock implements ToggleFavoriteUseCase {}

class MockGetDoctorsByCategoryUseCase extends Mock
    implements GetDoctorsByCategoryUseCase {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late HomeCubit homeCubit;
  late MockGetAllDoctorsUseCase mockGetAllDoctorsUseCase;
  late MockGetDoctorByIdUseCase mockGetDoctorByIdUseCase;
  late MockSearchDoctorsUseCase mockSearchDoctorsUseCase;
  late MockToggleFavoriteUseCase mockToggleFavoriteUseCase;
  late MockGetDoctorsByCategoryUseCase mockGetDoctorsByCategoryUseCase;

  setUp(() {
    mockGetAllDoctorsUseCase = MockGetAllDoctorsUseCase();
    mockGetDoctorByIdUseCase = MockGetDoctorByIdUseCase();
    mockSearchDoctorsUseCase = MockSearchDoctorsUseCase();
    mockToggleFavoriteUseCase = MockToggleFavoriteUseCase();
    mockGetDoctorsByCategoryUseCase = MockGetDoctorsByCategoryUseCase();

    homeCubit = HomeCubit(
      mockGetAllDoctorsUseCase,
      mockGetDoctorsByCategoryUseCase,
      mockSearchDoctorsUseCase,
      mockGetDoctorByIdUseCase,
      mockToggleFavoriteUseCase,
    );
  });

  tearDown(() {
    homeCubit.close();
  });

  blocTest(
    'emits [HomeLoading, HomeLoaded] when GetAllDoctorsUseCase is called',
    build: () {
      final doctors = List.generate(
        5,
        (index) => DoctorModel(
          id: index,
          name: 'Doctor $index',
          specialization: Specialization(
            id: index,
            name: 'Specialization $index',
          ),
          isFavorite: false,
        ),
      );
      when(
        () => mockGetAllDoctorsUseCase.call(const NoParams()),
      ).thenAnswer((_) async => ApiResult.success(doctors));
      return homeCubit;
    },
    act: (cubit) => cubit.getAllDoctors(),
    expect: () {
      final doctors = List.generate(
        5,
        (index) => DoctorModel(
          id: index,
          name: 'Doctor $index',
          specialization: Specialization(
            id: index,
            name: 'Specialization $index',
          ),
          isFavorite: false,
        ),
      );
      return [
        isA<AllDoctorsLoading>(),
        isA<AllDoctorsSuccess>().having(
          (state) => state.doctors,
          'doctors',
          doctors,
        ),
      ];
    },
  );
}
