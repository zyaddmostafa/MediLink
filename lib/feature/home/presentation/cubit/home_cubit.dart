import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

import '../../../../core/api_helpers/api_error_model.dart';
import '../../data/model/doctor_model.dart';
import '../../domain/usecases/get_all_doctors_use_case.dart';
import '../../domain/usecases/get_doctors_by_category_use_case.dart';
import '../../domain/usecases/search_doctors_use_case.dart';
import '../../domain/usecases/get_doctor_by_id_use_case.dart';
import '../../domain/usecases/toggle_favorite_use_case.dart';
import '../../domain/usecases/base_use_case.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetAllDoctorsUseCase _getAllDoctorsUseCase;
  final GetDoctorsByCategoryUseCase _getDoctorsByCategoryUseCase;
  final SearchDoctorsUseCase _searchDoctorsUseCase;
  final GetDoctorByIdUseCase _getDoctorByIdUseCase;
  final ToggleFavoriteUseCase _toggleFavoriteUseCase;

  // RxDart subject for debounced search
  final _searchSubject = BehaviorSubject<String>();
  late StreamSubscription _searchSubscription;

  HomeCubit(
    this._getAllDoctorsUseCase,
    this._getDoctorsByCategoryUseCase,
    this._searchDoctorsUseCase,
    this._getDoctorByIdUseCase,
    this._toggleFavoriteUseCase,
  ) : super(HomeCubitInitial()) {
    _initializeSearchDebounce();
  }

  void _initializeSearchDebounce() {
    _searchSubscription = _searchSubject
        .debounceTime(const Duration(milliseconds: 500))
        .distinct()
        .listen((query) {
          if (query.isNotEmpty) {
            _performSearch(query);
          } else {
            _performSearch('');
          }
        });
  }

  void getAllDoctors() async {
    emit(AllDoctorsLoading());
    final response = await _getAllDoctorsUseCase.call(const NoParams());

    response.when(
      onSuccess: (List<DoctorModel> doctors) {
        emit(AllDoctorsSuccess(doctors));
      },
      onError: (ApiErrorModel error) {
        emit(AllDoctorsError(error));
      },
    );
  }

  void searchDoctors(String query) {
    // Add the query to the subject for debounced processing
    _searchSubject.add(query);
  }

  void _performSearch(String query) async {
    emit(SearchDoctorsLoading());
    final response = await _searchDoctorsUseCase.call(query);

    response.when(
      onSuccess: (List<DoctorModel> doctors) {
        emit(SearchDoctorsSuccess(doctors));
      },
      onError: (ApiErrorModel error) {
        emit(SearchDoctorsError(error));
      },
    );
  }

  void getDoctorsByCategory(int categoryId) async {
    emit(DoctorsByCategoryLoading());
    final response = await _getDoctorsByCategoryUseCase.call(categoryId);

    response.when(
      onSuccess: (List<DoctorModel> doctors) {
        emit(DoctorsByCategorySuccess(doctors));
      },
      onError: (ApiErrorModel error) {
        emit(DoctorsByCategoryError(error));
      },
    );
  }

  void getDoctorById(int id) async {
    emit(DoctorByIdLoading());
    final response = await _getDoctorByIdUseCase.call(id);

    response.when(
      onSuccess: (DoctorModel doctor) {
        emit(DoctorByIdSuccess(doctor));
      },
      onError: (ApiErrorModel error) {
        emit(DoctorByIdError(error));
      },
    );
  }

  // New method to toggle favorite status
  Future<void> toggleFavorite(int doctorId) async {
    try {
      await _toggleFavoriteUseCase.call(doctorId);
      // Refresh the current list to update favorite status
      // You can emit a specific state or refresh the current data
    } catch (e) {
      // Handle error if needed
    }
  }

  @override
  Future<void> close() {
    _searchSubscription.cancel();
    _searchSubject.close();
    return super.close();
  }
}
