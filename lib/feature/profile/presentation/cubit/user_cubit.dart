import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/model/user_response.dart';
import '../../data/model/update_user_request.dart';
import '../../data/repo/user_repo.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepo userRepo;

  UserCubit(this.userRepo) : super(UserInitial());

  void getUserProfile() async {
    emit(UserLoading());

    final result = await userRepo.getUserProfile();

    result.when(
      onSuccess: (user) {
        emit(UserSuccess(user));
      },
      onError: (error) {
        emit(UserError(error.message ?? "Unknown error"));
      },
    );
  }

  void updateUserProfile(UpdateUserRequest request) async {
    emit(UserLoading());
    final result = await userRepo.updateUserProfile(request);
    result.when(
      onSuccess: (userResponse) {
        emit(UserSuccess(userResponse.responseData!.first));
      },
      onError: (error) {
        emit(UserError(error.message ?? "Unknown error"));
      },
    );
  }
}
