import 'package:flutter/foundation.dart';

class   Logger {
  static void log(String message, {String? tag}) {
    if (kDebugMode) {
      final timestamp = DateTime.now().toIso8601String();
      final logMessage = tag != null ? '[$tag] $message' : message;
      print('$timestamp: $logMessage');
    }
  }

  static void logError(String message, dynamic error, {String? tag}) {
    if (kDebugMode) {
      final timestamp = DateTime.now().toIso8601String();
      final logMessage = tag != null ? '[$tag] $message' : message;
      print('$timestamp: ERROR - $logMessage');
      print('$timestamp: ERROR DETAILS - $error');
    }
  }

  static void logNetwork(String message, {String? tag}) {
    log('🌐 $message', tag: tag);
  }

  static void logNetworkError(String message, dynamic error, {String? tag}) {
    logError('🌐 $message', error, tag: tag);
  }
}
