abstract class Result<T> {}

class SuccessResults<T> extends Result<T> {
  final T value;
  SuccessResults({required this.value});
}

class FailureResults<T> extends Result<T> implements Exception{
  final String errorMessage;
  FailureResults({required this.errorMessage});
}

class LoadingResults<T> extends Result {
  LoadingResults();
}
