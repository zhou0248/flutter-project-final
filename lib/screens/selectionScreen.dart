import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/helpers/appTheme.dart';
import 'package:flutter_project/helpers/httpMVDBHelper.dart';
import 'package:flutter_project/helpers/httpSessionHelper.dart';

class MovieSelectionScreen extends StatefulWidget {
  const MovieSelectionScreen({super.key});

  @override
  State<MovieSelectionScreen> createState() => _MovieSelectionState();
}

class _MovieSelectionState extends State<MovieSelectionScreen> {
  final baseUrl = 'https://api.themoviedb.org/3/movie/popular';
  final imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  List movies = [];
  int movieLeft = 0;
  bool isLoading = true;
  bool match = false;

  @override
  void initState() {
    super.initState();
    _fetchMovies();
    movieLeft = movies.length;
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
              child: Column(
                children: [
                  Dismissible(
                    key: Key(movies[0]['id'].toString()),
                    onDismissed: (direction) async {
                      movieLeft == 1 ? await _fetchMovies() : null;
                      _vote(movies[0]['id'], false);
                      movieLeft--;
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
                            SizedBox(
                              height: 400,
                              child: movies[0]['poster_path'] == null
                                  ? Image.asset('assets/default_poster.jpg')
                                  : Image.network(
                                      '$imageBaseUrl${movies[0]['poster_path']}',
                                    ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: AppTheme.defaultPadding,
                    child: ElevatedButton(
                        style: AppTheme.elevatedButtonStyle,
                        onPressed: () async {
                          var result = await _vote(movies[0]['id'], true);
                          if (result) {
                            setState(() {
                              match = true;
                            });
                            await _showDialog();
                          }
                          movieLeft == 1 ? await _fetchMovies() : null;
                          movieLeft--;
                          setState(() {
                            movies.removeAt(0);
                          });
                        },
                        child: const Text('Upvote')),
                  ),
                  ElevatedButton(
                    style: AppTheme.elevatedButtonStyle,
                    onPressed: () async {
                      _vote(movies[0]['id'], false);
                      movieLeft == 1 ? await _fetchMovies() : null;
                      movieLeft--;
                      setState(() {
                        movies.removeAt(0);
                      });
                    },
                    child: const Text('Downvote'),
                  ),
                ],
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

  Future<bool> _vote(int movieId, bool vote) async {
    final httpSession = HttpSessionHelper();
    final response = await httpSession.voteMovie(movieId.toString(), vote);
    return response;
  }

//https://api.flutter.dev/flutter/material/AlertDialog-class.html
  Future<void> _showDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: AppTheme.colorScheme.secondary,
          title: const Text('You have a match!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                SizedBox(
                  child: Image.network(
                    '$imageBaseUrl${movies[0]['poster_path']}',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
