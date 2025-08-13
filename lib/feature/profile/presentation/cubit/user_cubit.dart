import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/model/get_user_response.dart';
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
      onSuccess: (userResponse) {
        if (userResponse.userdata.isNotEmpty) {
          emit(UserLoaded(userResponse.userdata.first));
        } else {
          emit(UserError("No user data found"));
        }
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
        emit(UserLoaded(userResponse.userdata.first));
      },
      onError: (error) {
        emit(UserError(error.message ?? "Unknown error"));
      },
    );
  }
}
