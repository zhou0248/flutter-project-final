import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MovieSelectionScreen extends StatefulWidget {
  const MovieSelectionScreen({super.key});

  @override
  State<MovieSelectionScreen> createState() => _MovieSelectionState();
}

class _MovieSelectionState extends State<MovieSelectionScreen> {
  final baseUrl = 'https://api.themoviedb.org/3/movie/popular';
  final imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  List movies = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Choice'),
        backgroundColor: Colors.amber,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Dismissible(
                key: Key(movies[0]['id'].toString()),
                onDismissed: (direction) {
                  setState(() {
                    movies.removeAt(0);
                  });
                },
                child: Stack(
                  children: [
                    Image.network('$imageBaseUrl${movies[0]['poster_path']}'),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> _fetchMovies() async {
    final apiKey = dotenv.env['TMDB_API_KEY'];
    final response = await http.get(Uri.parse('$baseUrl?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        movies = data['results'];
        isLoading = false;
      });

      if (kDebugMode) {
        print(data);
        print(data['results']);
      }
    } else {
      setState(() {
        isLoading = true;
      });
    }
  }
}
