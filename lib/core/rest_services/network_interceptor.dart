import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:the_movie_db_app/core/utils/logger.dart';

class NetworkInterceptor {
  static const int _maxRetries = 3;
  static const Duration _defaultTimeout = Duration(seconds: 30);
  static const Duration _retryDelay = Duration(seconds: 2);

  /// Makes an HTTP GET request with automatic retry logic and timeout handling
  static Future<http.Response> getWithRetry(
    String url, {
    int maxRetries = _maxRetries,
    Duration timeout = _defaultTimeout,
    Duration retryDelay = _retryDelay,
  }) async {
    int attempts = 0;
    Exception? lastException;

    Logger.logNetwork('Starting request to: $url', tag: 'NetworkInterceptor');

    while (attempts < maxRetries) {
      try {
        attempts++;
        Logger.logNetwork('Attempt $attempts of $maxRetries', tag: 'NetworkInterceptor');
        
        // Create a new client for each attempt to avoid connection pooling issues
        final client = http.Client();
        
        try {
          final response = await client
              .get(Uri.parse(url))
              .timeout(timeout);
          
          client.close();
          Logger.logNetwork('Request successful on attempt $attempts', tag: 'NetworkInterceptor');
          return response;
        } finally {
          client.close();
        }
      } on SocketException catch (e) {
        lastException = e;
        Logger.logNetworkError('SocketException on attempt $attempts: ${e.message}', e, tag: 'NetworkInterceptor');
        
        if (attempts >= maxRetries) {
          Logger.logNetworkError('Max retries reached for SocketException', e, tag: 'NetworkInterceptor');
          throw SocketException(
            'Connection failed after $maxRetries attempts: ${e.message}',
            address: e.address,
            port: e.port,
          );
        }
        
        // Wait before retrying with exponential backoff
        final delay = Duration(seconds: attempts * retryDelay.inSeconds);
        Logger.logNetwork('Waiting ${delay.inSeconds} seconds before retry', tag: 'NetworkInterceptor');
        await Future.delayed(delay);
        continue;
      } on TimeoutException catch (e) {
        lastException = e;
        Logger.logNetworkError('TimeoutException on attempt $attempts', e, tag: 'NetworkInterceptor');
        
        if (attempts >= maxRetries) {
          Logger.logNetworkError('Max retries reached for TimeoutException', e, tag: 'NetworkInterceptor');
          throw TimeoutException('Request timed out after $maxRetries attempts');
        }
        
        final delay = Duration(seconds: attempts * retryDelay.inSeconds);
        Logger.logNetwork('Waiting ${delay.inSeconds} seconds before retry', tag: 'NetworkInterceptor');
        await Future.delayed(delay);
        continue;
      } catch (e) {
        lastException = e as Exception;
        Logger.logNetworkError('Unexpected error on attempt $attempts: ${e.toString()}', e, tag: 'NetworkInterceptor');
        
        if (attempts >= maxRetries) {
          Logger.logNetworkError('Max retries reached for unexpected error', e, tag: 'NetworkInterceptor');
          rethrow;
        }
        
        final delay = Duration(seconds: attempts * retryDelay.inSeconds);
        Logger.logNetwork('Waiting ${delay.inSeconds} seconds before retry', tag: 'NetworkInterceptor');
        await Future.delayed(delay);
        continue;
      }
    }
    
    Logger.logNetworkError('All retry attempts failed', lastException, tag: 'NetworkInterceptor');
    throw lastException ?? Exception('Failed to make request after $maxRetries attempts');
  }

  /// Checks if the device has internet connectivity
  static Future<bool> hasInternetConnection() async {
    try {
      Logger.logNetwork('Checking internet connectivity...', tag: 'NetworkInterceptor');
      final result = await InternetAddress.lookup('google.com');
      final hasConnection = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      Logger.logNetwork('Internet connectivity: ${hasConnection ? 'Available' : 'Not available'}', tag: 'NetworkInterceptor');
      return hasConnection;
    } on SocketException catch (e) {
      Logger.logNetworkError('Internet connectivity check failed', e, tag: 'NetworkInterceptor');
      return false;
    }
  }

  /// Checks if the error is a network-related error
  static bool isNetworkError(dynamic error) {
    return error is SocketException || 
           error is TimeoutException || 
           error.toString().contains('Connection reset by peer') ||
           error.toString().contains('Connection refused') ||
           error.toString().contains('Network is unreachable');
  }

  /// Gets a user-friendly error message for network errors
  static String getNetworkErrorMessage(dynamic error) {
    if (error is SocketException) {
      if (error.message.contains('Connection reset by peer')) {
        return 'Connection was reset. Please check your internet connection and try again.';
      } else if (error.message.contains('Connection refused')) {
        return 'Connection was refused. The server might be unavailable.';
      } else if (error.message.contains('Network is unreachable')) {
        return 'Network is unreachable. Please check your internet connection.';
      }
      return 'Network error: ${error.message}';
    } else if (error is TimeoutException) {
      return 'Request timed out. Please check your internet connection and try again.';
    } else if (error.toString().contains('Connection reset by peer')) {
      return 'Connection was reset. Please check your internet connection and try again.';
    }
    return 'Network error occurred. Please try again.';
  }
}
