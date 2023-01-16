class ErrorResponse {
  int code;
  String message;

  ErrorResponse({
    required this.code,
    required this.message,
  });

  factory ErrorResponse.generic(String message) => ErrorResponse(
        code: 0,
        message: message,
      );
}
