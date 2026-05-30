import 'package:dio/dio.dart';
import 'package:order_now/core/network/api_error.dart';

class ApiExceptions {
  static ApiError handleError(DioException dioException) {
    final statusCode = dioException.response?.statusCode;
    final data = dioException.response?.data;

    if (data is Map<String, dynamic> && data['message'] != null) {
      return ApiError(message: data['message'], statusCode: statusCode);
    }

    return switch (dioException.type) {
      DioExceptionType.connectionTimeout => ApiError(
        message:
            'Connection timed out. Please check your internet and try again.',
        statusCode: statusCode,
      ),
      DioExceptionType.sendTimeout => ApiError(
        message: 'Request timed out. Please try again later.',
        statusCode: statusCode,
      ),
      DioExceptionType.receiveTimeout => ApiError(
        message: 'Server took too long to respond. Please try again.',
        statusCode: statusCode,
      ),
      DioExceptionType.badResponse => ApiError(
        message: _messageFromStatusCode(statusCode),
        statusCode: statusCode,
      ),
      DioExceptionType.badCertificate => ApiError(
        message: 'Secure connection failed. Please try again later.',
        statusCode: statusCode,
      ),
      DioExceptionType.cancel => ApiError(
        message: 'Request was cancelled.',
        statusCode: statusCode,
      ),
      DioExceptionType.connectionError => ApiError(
        message: 'No internet connection. Please check your network settings.',
        statusCode: statusCode,
      ),
      DioExceptionType.unknown => ApiError(
        message: 'Something went wrong. Please try again.',
        statusCode: statusCode,
      ),
    };
  }

  /// Maps common HTTP status codes to user-friendly messages.
  static String _messageFromStatusCode(int? statusCode) {
    return switch (statusCode) {
      400 => 'Invalid request. Please check your input and try again.',
      401 => 'Session expired. Please log in again.',
      403 => 'You don\'t have permission to perform this action.',
      404 => 'The requested resource was not found.',
      408 => 'Request timed out. Please try again.',
      409 => 'A conflict occurred. Please refresh and try again.',
      422 => 'Please check your input and try again.',
      429 => 'Too many requests. Please wait a moment and try again.',
      500 => 'Server error. We\'re working on it — please try again later.',
      502 => 'Server is temporarily unavailable. Please try again later.',
      503 => 'Service is under maintenance. Please try again shortly.',
      _ => 'Something went wrong. Please try again.',
    };
  }
}
