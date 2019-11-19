import 'package:flutter/material.dart';
import 'package:movie_search/api/tmdb.dart' as api;
import 'package:movie_search/model/movie.dart';
import 'package:movie_search/widgets/loading.dart';

class MoviePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int movieId = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: FutureBuilder(
        future: api.getMovie(movieId),
        builder: (context, AsyncSnapshot<Movie> snapshot) {
          // TODO: if snapshot.hasError...
          if (!snapshot.hasData) {
            return Loading();
          }
          return _MoviePageBody(snapshot.data);
        },
      ),
    );
  }
}

class _MoviePageBody extends StatelessWidget {
  final Movie movie;
  const _MoviePageBody(this.movie);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Text(movie.title),
          expandedHeight: 200,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  api.imageUri(movie.backdropPath),
                ),
              ),
            ),
          ),
        ),
        // if (movie != null)
        //   Image.network(api.imageUri(movie.backdropPath)),
        SliverList(
          delegate: SliverChildListDelegate([
            Text(movie.title),
            Text(movie.overview),
            Text(movie.genres.join(', ')),
          ]),
        ),
      ],
    );
  }
}
