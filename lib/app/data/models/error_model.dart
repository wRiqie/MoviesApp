class ErrorModel {
  int? code;
  String message;

  ErrorModel({
    this.code,
    required this.message,
  });

  factory ErrorModel.generic(String message) => ErrorModel(
        code: 0,
        message: message,
      );
}
