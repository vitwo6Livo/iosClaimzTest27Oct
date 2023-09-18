class AppException implements Exception {
  final _message;
  final _prefix;

  AppException(this._message, this._prefix);

  String toString() {
    return '$_prefix$_message';
  }
}

//Exception when response takes too long to return
class FetchDataException extends AppException {
  FetchDataException(String? message)
      : super(message, 'Error During Communication');
}

//Exception when given URL is invalid
class BadRequestException extends AppException {
  BadRequestException(String? message) : super(message, 'Invalid Request');
}

//During Token Mismatch
class UnauthorizedException extends AppException {
  UnauthorizedException(String? message)
      : super(message, 'Unauthorized Request');
}

//During Invalid Inputs
class InvalidInputException extends AppException {
  InvalidInputException(String? message) : super(message, 'Invalid Input');
}
