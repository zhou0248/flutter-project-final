import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_project/helpers/appTheme.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_project/helpers/httpMVDBHelper.dart';

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
        title: const Text("Movie Night"),
        foregroundColor: AppTheme.appBarTheme.foregroundColor,
        backgroundColor: AppTheme.appBarTheme.backgroundColor,
        titleTextStyle: AppTheme.textTheme.titleMedium,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Padding(
                padding: AppTheme.defaultPadding,
                child: Dismissible(
                  key: Key(movies[0]['id'].toString()),
                  onDismissed: (direction) {
                    setState(() {
                      movies.removeAt(0);
                    });
                  },
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: AppTheme.defaultPadding,
                            child: Text(
                              movies[0]['title'],
                              style: AppTheme.textTheme.titleMedium,
                            ),
                          ),
                          movies[0]['poster_path'] == null
                              ? Image.asset('assets/default_poster.jpg')
                              : Image.network(
                                  '$imageBaseUrl${movies[0]['poster_path']}',
                                )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Future<void> _fetchMovies() async {
    final getMovie = HttpMVDBHelper();
    try {
      var movieData = await getMovie.getPopular();
      setState(() {
        movies = movieData;
        isLoading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
