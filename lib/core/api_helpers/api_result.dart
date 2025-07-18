import 'api_error_handler.dart';

class ApiResult<T> {
  ApiResult._();
  factory ApiResult.success(T data) = Success<T>;
  factory ApiResult.error(ErrorHandler e) = Failure<T>;
  when({
    required Function(T data) onSuccess,
    required Function(ErrorHandler error) onError,
  }) {
    if (this is Success<T>) {
      return onSuccess((this as Success<T>).data);
    } else {
      return onError(ErrorHandler.handle((this as Failure).error));
    }
  }
}

class Success<T> extends ApiResult<T> {
  final T data;

  Success(this.data) : super._();
}

class Failure<T> extends ApiResult<T> {
  final ErrorHandler error;

  Failure(this.error) : super._();
}
