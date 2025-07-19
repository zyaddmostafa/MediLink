import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../../core/api_helpers/api_error_model.dart';
import '../../../../../core/api_helpers/dio_factory.dart';
import '../../../../../core/helpers/constants.dart';
import '../../../../../core/helpers/shared_pref_helper.dart';
import '../../../data/models/login_request_body.dart';
import '../../../data/models/login_response.dart';
import '../../../data/repos/auth_repo_impl.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepoImpl _authRepoImpl;
  LoginCubit(this._authRepoImpl) : super(LoginInitial());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void login() async {
    emit(LoginLoading());
    final response = await _authRepoImpl.login(
      LoginRequestBody(
        email: emailController.text,
        password: passwordController.text,
      ),
    );
    response.when(
      onSuccess: (LoginResponse data) {
        saveUserToken(data.userData?.token ?? '');
        emit(LoginSuccess(data));
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

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    formKey.currentState?.reset();
    emailController.clear();
    passwordController.clear();
    return super.close();
  }
}
