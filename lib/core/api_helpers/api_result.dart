import 'api_error_model.dart';

class ApiResult<T> {
  ApiResult._();
  factory ApiResult.success(T data) = Success<T>;
  factory ApiResult.failure(ApiErrorModel e) = Failure<T>;
  when({
    required Function(T data) onSuccess,
    required Function(ApiErrorModel error) onError,
  }) {
    if (this is Success<T>) {
      return onSuccess((this as Success<T>).data);
    } else {
      return onError((this as Failure<T>).error);
    }
  }
}

class Success<T> extends ApiResult<T> {
  final T data;

  Success(this.data) : super._();
}

class Failure<T> extends ApiResult<T> {
  final ApiErrorModel error;

  Failure(this.error) : super._();
}
