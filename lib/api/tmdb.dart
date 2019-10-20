
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movie_search/model/movie.dart';

const String host = 'api.themoviedb.org';

Future<List<Movie>> searchMovies(String query) async {
  final uri = Uri.https(host, "/3/search/movie", {
    "api_key": DotEnv().env['apikey'],
    "query": query,
  });
  final response = await http.get(uri);
  final json = jsonDecode(response.body);
  return json['results'].map((x) => Movie.fromJson(x)).cast<Movie>().toList();
}



