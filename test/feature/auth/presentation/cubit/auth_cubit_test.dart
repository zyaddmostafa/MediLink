import 'package:bloc_test/bloc_test.dart';
import 'package:doctor_appoinment/core/api_helpers/api_result.dart';
import 'package:doctor_appoinment/core/model/api_response_model.dart';
import 'package:doctor_appoinment/feature/auth/data/models/login_request_body.dart';
import 'package:doctor_appoinment/feature/auth/data/models/user_model.dart';
import 'package:doctor_appoinment/feature/auth/data/repos/auth_repo.dart';
import 'package:doctor_appoinment/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepo extends Mock implements AuthRepo {}

void main() {
  late AuthCubit authCubit;
  late MockAuthRepo mockAuthRepo;

  setUpAll(() {
    // Initialize Flutter bindings for tests
    TestWidgetsFlutterBinding.ensureInitialized();
    registerFallbackValue(LoginRequestBody(email: '', password: ''));
  });

  setUp(() {
    mockAuthRepo = MockAuthRepo();
    authCubit = AuthCubit(mockAuthRepo);
  });

  tearDown(() {
    authCubit.close();
  });

  blocTest<AuthCubit, AuthState>(
    'emits [LoginLoading, LoginSuccess] when login is successful',
    build: () {
      // Arrange
      final userData = UserModel(userName: 'test_user', token: 'mock_token');
      final result = ApiResult.success(
        ApiResponseModel(
          message: 'Login successful',
          responseData: userData,
          status: true,
          code: 200,
        ),
      );
      when(() => mockAuthRepo.login(any())).thenAnswer((_) async => result);
      return authCubit;
    },
    // Act
    act: (cubit) => cubit.login(
      LoginRequestBody(email: 'test@example.com', password: 'password'),
    ),
    // Assert
    expect: () => [
      isA<LoginLoading>(),
      isA<LoginSuccess>().having(
        (state) => state.userData.token,
        'userData.token',
        'mock_token',
      ),
    ],
  );
}
