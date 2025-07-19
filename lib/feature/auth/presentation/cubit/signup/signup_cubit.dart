import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import '../../../../../core/api_helpers/api_error_model.dart';
import '../../../data/models/sign_up_request_body.dart';
import '../../../data/models/sign_up_response.dart';
import '../../../data/repos/auth_repo_impl.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepoImpl _authRepoImpl;
  SignupCubit(this._authRepoImpl) : super(SignupInitial());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmation = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> emailAndPhoneFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> passwordsFormKey = GlobalKey<FormState>();

  void signup(int gender) async {
    emit(SignupLoading());
    final response = await _authRepoImpl.signup(
      SignupRequestBody(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        passwordConfirmation: passwordConfirmation.text,
        phone: phoneNumberController.text,
        gender: gender,
      ),
    );
    response.when(
      onSuccess: (SignupResponse data) {
        emit(SignupSuccess(data));
      },
      onError: (ApiErrorModel error) {
        emit(SignupError(error));
      },
    );
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    emailAndPhoneFormKey.currentState?.reset();
    passwordsFormKey.currentState?.reset();
    emailController.clear();
    passwordController.clear();
    passwordConfirmation.clear();
    phoneNumberController.clear();
    nameController.clear();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmation.dispose();
    phoneNumberController.dispose();
    nameController.dispose();
    // ...
    return super.close();
  }
}
