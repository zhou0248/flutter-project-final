import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/helpers/appTheme.dart';
import 'package:flutter_project/helpers/httpMVDBHelper.dart';
import 'package:flutter_project/helpers/httpSessionHelper.dart';
import 'package:flutter_project/screens/welcomeScreen.dart';

class MovieSelectionScreen extends StatefulWidget {
  const MovieSelectionScreen({super.key});

  @override
  State<MovieSelectionScreen> createState() => _MovieSelectionState();
}

class _MovieSelectionState extends State<MovieSelectionScreen> {
  final baseUrl = 'https://api.themoviedb.org/3/movie/popular';
  final imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  List movies = [];
  int movieIndex = 0;
  bool isLoading = true;
  bool match = false;

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
      body: SingleChildScrollView(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: match
                    ? null
                    : Column(
                        children: [
                          movieIndex == 19
                              ? Padding(
                                  padding: AppTheme.largePadding,
                                  child: ElevatedButton(
                                    style: AppTheme.elevatedButtonStyle,
                                    onPressed: () async {
                                      await _fetchMovies();
                                      setState(() {
                                        movieIndex = 0;
                                      });
                                    },
                                    child: const Text('Get More Movies'),
                                  ))
                              : Dismissible(
                                  key: Key(movies[0]['id'].toString()),
                                  onDismissed: (direction) async {
                                    _vote(movies[0]['id'], false);
                                    movieIndex++;
                                    setState(() {
                                      movies.removeAt(0);
                                    });
                                  },
                                  child: Stack(
                                    children: [
                                      SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: AppTheme.defaultPadding,
                                              child: Text(
                                                movies[0]['title'],
                                                style: AppTheme
                                                    .textTheme.titleMedium,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 350,
                                              child: movies[0]['poster_path'] ==
                                                      null
                                                  ? Image.asset(
                                                      'assets/default_poster.jpg')
                                                  : Image.network(
                                                      '$imageBaseUrl${movies[0]['poster_path']}',
                                                    ),
                                            ),
                                            Text(
                                              'Release Date: ' +
                                                  movies[0]['release_date'],
                                              style:
                                                  AppTheme.textTheme.bodySmall,
                                            ),
                                            Text(
                                                'Rating: ' +
                                                    movies[0]['vote_average']
                                                        .toString(),
                                                style: AppTheme
                                                    .textTheme.bodySmall),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          movieIndex == 19
                              ? const Padding(
                                  padding: AppTheme.defaultPadding, child: null)
                              : Padding(
                                  padding: AppTheme.defaultPadding,
                                  child: ElevatedButton(
                                    style: AppTheme.elevatedButtonStyle,
                                    onPressed: () async {
                                      var result =
                                          await _vote(movies[0]['id'], true);
                                      if (result) {
                                        setState(() {
                                          match = true;
                                        });
                                        await _showDialog();
                                      }
                                      movieIndex == 19
                                          ? await _fetchMovies()
                                          : null;
                                      movieIndex++;
                                      setState(() {
                                        movies.removeAt(0);
                                      });
                                    },
                                    child: Text(
                                      'Upvote',
                                    ),
                                  ),
                                ),
                          movieIndex == 19
                              ? const Padding(
                                  padding: AppTheme.defaultPadding, child: null)
                              : ElevatedButton(
                                  style: AppTheme.elevatedButtonStyle,
                                  onPressed: () async {
                                    _vote(movies[0]['id'], false);
                                    movieIndex == 19
                                        ? await _fetchMovies()
                                        : null;
                                    movieIndex++;
                                    setState(() {
                                      movies.removeAt(0);
                                    });
                                  },
                                  child: Text(
                                    'Downvote',
                                  ),
                                )
                        ],
                      ),
              ),
      ),
    );
  }

  Future<void> _fetchMovies() async {
    final getMovie = HttpMVDBHelper();
    var page = 1;
    try {
      var movieData = await getMovie.getPopular(page);
      setState(() {
        movies = movieData;
        isLoading = false;
      });
      page++;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$e'),
          ),
        );
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
          title: Text(
            'You have a match!',
            style: AppTheme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
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
            Center(
              child: TextButton(
                style: AppTheme.elevatedButtonStyle,
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => WelcomeScreen()),
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }
}
