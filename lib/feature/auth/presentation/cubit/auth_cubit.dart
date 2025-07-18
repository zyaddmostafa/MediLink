import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/api_helpers/api_error_model.dart';
import '../../../../core/api_helpers/dio_factory.dart';
import '../../../../core/helpers/constants.dart';
import '../../../../core/helpers/shared_pref_helper.dart';
import '../../data/models/login_response.dart';
import '../../data/models/sign_up_response.dart';
import '../../data/repos/auth_repo_impl.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepoImpl _authRepoImpl;
  AuthCubit(this._authRepoImpl) : super(AuthInitial());

  Future<void> saveUserToken(String token) async {
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.userToken, token);
    DioFactory.setTokenIntoHeaderAfterLogin(token);
  }
}
