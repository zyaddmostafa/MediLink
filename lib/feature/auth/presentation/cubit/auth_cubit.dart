import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import '../../../../core/api_helpers/api_error_model.dart';
import '../../../../core/api_helpers/dio_factory.dart';
import '../../../../core/helpers/constants.dart';
import '../../../../core/helpers/shared_pref_helper.dart';
import '../../data/models/login_request_body.dart';
import '../../data/models/sign_up_request_body.dart';
import '../../data/models/sign_up_response.dart';
import '../../data/models/user_model.dart';
import '../../data/repos/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _authRepoImpl;
  AuthCubit(this._authRepoImpl) : super(AuthInitial());

  void login(LoginRequestBody loginRequestBody) async {
    emit(LoginLoading());
    final response = await _authRepoImpl.login(loginRequestBody);

    response.when(
      onSuccess: (UserModel userData) {
        saveUserToken(userData.token ?? '');
        emit(LoginSuccess(userData));
      },
      onError: (ApiErrorModel error) {
        emit(LoginError(error));
      },
    );
  }

  Future<void> saveUserToken(String token) async {
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.userToken, token);
    DioFactory.setTokenIntoHeaderAfterLogin(token);
  }

  void signup(SignupRequestBody signupRequestBody) async {
    emit(SignupLoading());
    final response = await _authRepoImpl.signup(signupRequestBody);
    response.when(
      onSuccess: (SignupResponse signupResponse) {
        emit(SignupSuccess(signupResponse));
      },
      onError: (ApiErrorModel error) {
        emit(SignupError(error));
      },
    );
  }

  void logout() async {
    emit(LogoutLoading());
    final response = await _authRepoImpl.logout();
    response.when(
      onSuccess: (_) {
        emit(LogoutSuccess());
      },
      onError: (ApiErrorModel error) {
        emit(LogoutError(error));
      },
    );
  }
}
