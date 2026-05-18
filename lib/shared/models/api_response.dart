class ApiResponse<T> {
  ApiResponse({
    required this.data,
    this.message,
  });

  final T data;
  final String? message;
}
