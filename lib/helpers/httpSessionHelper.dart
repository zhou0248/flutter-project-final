import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpSessionHelper {
  int code = 0;
  String baseURL = 'https://movie-night-api.onrender.com/';
  String sessionID = '';
  String startSession = 'start-session';
  String joinSession = 'join-session';
  String vote = 'vote-movie';

  Future<int> getCode() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('device_id');
    final response =
        await http.get(Uri.parse('$baseURL$startSession?device_id=$id'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      sessionID = data['session_id'];
      await prefs.setString('session_id', sessionID);
      code = data['code'] = int.parse(data['code']);
      if (kDebugMode) {
        print('Data: $data\n Code $code');
      }
      return code;
    } else if (response.statusCode == 400) {
      throw Exception('Error: ${response.body.toString()}');
    } else {
      throw Exception('Failed to start session');
    }
  }

  Future<void> enterCode(int code) async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('device_id');
    final response = await http
        .get(Uri.parse('$baseURL$joinSession?device_id=$id&code=$code'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      sessionID = data['session_id'];
      await prefs.setString('session_id', sessionID);
    } else if (response.statusCode == 400) {
      throw Exception('Error: ${response.body.toString()}');
    } else {
      throw Exception('Failed to join session');
    }
  }

  Future<bool> voteMovie(String movieID, bool upvote) async {
    final prefs = await SharedPreferences.getInstance();
    final sessionId = prefs.getString('session_id');
    final response = await http.get(Uri.parse(
        '$baseURL$vote?&session_id=$sessionId&movie_id=$movieID&vote=$upvote'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      if (data['match'] == true) {
        return true;
      } else {
        return false;
      }
    } else if (response.statusCode == 767) {
      throw ('Error: You have already voted for this movie');
    } else {
      throw ('Failed to vote for movie');
    }
  }
}
