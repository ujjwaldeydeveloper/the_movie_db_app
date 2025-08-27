import 'package:dio/dio.dart';

class Failure {
  Failure({required this.message, this.statusCode, this.error, this.success});

  factory Failure.fromException(Exception exception) {
    if (exception is DioException) {
      return Failure(
        success: false,
        statusCode: exception.response?.statusCode,
        message: exception.message ?? '',
      );
    } else {
      return Failure(
        message: exception.toString(),
      );
    }
  }
  final int? statusCode;
  final String message;
  final String? error;
  final bool? success;

  @override
  String toString() {
    if (statusCode != null) {
      return 'Failure(statusCode: $statusCode, message: $message, error: $error)';
    } else {
      return 'Failure(message: $message)';
    }
  }
}