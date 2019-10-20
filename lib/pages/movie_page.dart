import 'package:flutter/material.dart';
import 'package:movie_search/api/tmdb.dart' as api;
import 'package:movie_search/model/movie.dart';
import 'package:movie_search/widgets/loading.dart';

class MoviePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int movieId = ModalRoute.of(context).settings.arguments;
    return _MoviePage(id: movieId);
  }
}

class _MoviePage extends StatefulWidget {
  final int id;
  _MoviePage({
    @required this.id,
  });

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<_MoviePage> {
  Movie _movie;

  @override
  void initState() {
    api.getMovie(widget.id).then((movie) {
      setState(() {
        _movie = movie;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _movie == null
          ? Loading()
          : Column(
              children: <Widget>[
                if (_movie != null)
                  Image.network(api.imageUri(_movie.backdropPath)),
                Text(_movie.title),
                Text(_movie.overview),
                Text(_movie.genres.join(', ')),
              ],
            ),
    );
  }
}
