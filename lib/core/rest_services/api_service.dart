import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://api.themoviedb.org/3';
  final String apiKey = '4b30bddb12d1d4ca01615d27804c32a9';
  
  // Configure HTTP client with proper timeouts and connection settings
  late final http.Client _httpClient;
  
  ApiService() {
    _httpClient = http.Client();
  }
  
  // Dispose method to close the HTTP client
  void dispose() {
    _httpClient.close();
  }

  final String upcomingMoviePath = '/movie/upcoming';
  String get upcomingMovieUrl => "$baseUrl$upcomingMoviePath?api_key=$apiKey";
  final String popularMoviePath = '/movie/popular';
  String get popularMovieUrl => "$baseUrl$popularMoviePath?api_key=$apiKey";
  final String topRatedMoviePath = '/movie/top_rated';
  String get topRatedMovieUrl => "$baseUrl$topRatedMoviePath?api_key=$apiKey";
  String moviePagePath(int pageNumber) => "$baseUrl/movie/popular?api_key=$apiKey&page=$pageNumber";
  
  // Generic method to make HTTP requests with retry logic
  Future<http.Response> makeRequestWithRetry(
    String url, {
    int maxRetries = 3,
    Duration timeout = const Duration(seconds: 30),
  }) async {
    int attempts = 0;
    
    while (attempts < maxRetries) {
      try {
        attempts++;
        
        final response = await _httpClient
            .get(Uri.parse(url))
            .timeout(timeout);
            
        return response;
      } on SocketException catch (e) {
        if (attempts >= maxRetries) {
          throw SocketException(
            'Connection failed after $maxRetries attempts: ${e.message}',
            address: e.address,
            port: e.port,
          );
        }
        
        // Wait before retrying (exponential backoff)
        await Future.delayed(Duration(seconds: attempts * 2));
        continue;
      } on TimeoutException {
        if (attempts >= maxRetries) {
          throw TimeoutException('Request timed out after $maxRetries attempts');
        }
        
        await Future.delayed(Duration(seconds: attempts * 2));
        continue;
      } catch (e) {
        if (attempts >= maxRetries) {
          rethrow;
        }
        
        await Future.delayed(Duration(seconds: attempts * 2));
        continue;
      }
    }
    
    throw Exception('Failed to make request after $maxRetries attempts');
  }
  
  // Method to check if device has internet connectivity
  Future<bool> hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}