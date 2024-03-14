class CustomException implements Exception {
  final String msg;
  const CustomException(this.msg);
  String toString() => msg;
}