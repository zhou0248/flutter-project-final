import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class HttpMVDBHelper {
  final baseUrl = 'https://api.themoviedb.org/3/movie';
  final popular = '/popular';
  final apiKey = dotenv.env['TMDB_API_KEY'];
  var movies = [];

  Future<dynamic> getPopular(int page) async {
    final result = await http
        .get(Uri.parse('$baseUrl$popular?api_key=$apiKey&page=$page'));
    if (result.statusCode == 200) {
      final data = jsonDecode(result.body);
      if (kDebugMode) {
        print(data);
      }
      movies = data['results'];
      return movies;
    } else {
      throw Exception(
          'Failed to load movies \nStatus Code: ${result.statusCode}');
    }
  }
}
