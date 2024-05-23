
///app 服务器异常
class AppServerException implements Exception {
  final int? code;
  final String? message;

  AppServerException({required this.code, required this.message});
}
