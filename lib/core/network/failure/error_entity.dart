class ErrorEntity {
  final String title;
  final String message;
  final String? errorCode;

  ErrorEntity({required this.title, required this.message, this.errorCode});
}
