import 'package:flutter/material.dart';
import 'package:movie_search/api/tmdb.dart' as api;
import 'package:movie_search/model/movie.dart';
import 'package:movie_search/widgets/loading.dart';
import 'package:provider/provider.dart';

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
          return Provider<Movie>.value(
            value: snapshot.data,
            child: _MoviePageBody(),
          );
        },
      ),
    );
  }
}

class _MoviePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = Provider.of<Movie>(context);
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
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: _Poster(),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: _Header(),
                ),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            _Overview(),
          ]),
        )
      ],
    );
  }
}

class _Overview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = Provider.of<Movie>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Text(movie.overview),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = Provider.of<Movie>(context);
    return Column(children: <Widget>[
      SizedBox(height: 16),
      _Title(),
      SizedBox(height: 8),
      Text(movie.genres.join(', ')),
    ]);
  }
}

class _Poster extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = Provider.of<Movie>(context);
    return AspectRatio(
      aspectRatio: 2 / 3,
      child: Material(
        elevation: 10,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(api.imageUri(movie.posterPath)),
            ),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = Provider.of<Movie>(context);
    return Text(
      movie.title,
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
