import 'package:flutter/material.dart';
import 'package:movie_search/api/tmdb.dart' as api;
import 'package:movie_search/model/movie.dart';

class ResultsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String query = ModalRoute.of(context).settings.arguments;
    return _ResultsPage(query);
  }
}

class _ResultsPage extends StatefulWidget {
  final String query;
  _ResultsPage(this.query);

  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<_ResultsPage> {
  List<Movie> _results;

  @override
  void initState() {
    api.searchMovies(widget.query).then((results) {
      setState(() {
        _results = results;
      });
    });
    super.initState();
  }

  Widget _loading() => Center(
        child: CircularProgressIndicator(),
      );

  Widget _list() => GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2 / 3,
        ),
        itemBuilder: (BuildContext context, int index) {
          final Movie movie = _results[index];
          if (movie.posterPath != null) {
            return Image.network(
              api.imageUri(movie.posterPath),
              fit: BoxFit.cover,
            );
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                movie.title,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          );
        },
        itemCount: _results.length,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Results')),
      body: (_results == null ? _loading() : _list()),
    );
  }
}
