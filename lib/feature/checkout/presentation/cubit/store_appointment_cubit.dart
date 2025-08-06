import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/api_helpers/api_error_model.dart';
import '../../data/model/store_appointment_request.dart';
import '../../data/model/store_appointment_response.dart';
import '../../data/repo/store_appointment_repo.dart';

part 'store_appointment_state.dart';

class StoreAppointmentCubit extends Cubit<StoreAppointmentState> {
  final StoreAppointmentRepo _storeAppointmentRepo;
  StoreAppointmentCubit(this._storeAppointmentRepo)
    : super(StoreAppointmentInitial());

  void storeAppointment(StoreAppointmentRequest request) async {
    emit(StoreAppointmentLoading());
    final result = await _storeAppointmentRepo.storeAppointment(request);

    result.when(
      onSuccess: (response) {
        emit(StoreAppointmentSuccess(response));
      },
      onError: (ApiErrorModel error) {
        emit(StoreAppointmentFailure(error.message ?? 'An error occurred'));
      },
    );
  }
}
