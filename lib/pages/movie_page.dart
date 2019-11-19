import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 220,
            padding: EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _Poster(),
                SizedBox(width: 10),
                Expanded(child: _Header()),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Text(
                'Storyline'.toUpperCase(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
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
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _Title(),
        SizedBox(height: 5),
        _Stars(),
        SizedBox(height: 5),
        _Genres(),
        SizedBox(height: 24),
        _InfoTable()
      ],
    );
  }
}

class _InfoTable extends StatelessWidget {
  final double fontSize = 12;

  _label(String s) => Padding(
        padding: const EdgeInsets.only(right: 8.0, bottom: 4.0),
        child: Text(s,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
            )),
      );

  _info(String s) => Text(s,
      style: TextStyle(
        fontSize: fontSize,
      ));

  @override
  Widget build(BuildContext context) {
    final Movie movie = Provider.of<Movie>(context);
    return Table(
      columnWidths: {
        0: IntrinsicColumnWidth(),
      },
      children: [
        TableRow(children: [
          _label('Director'),
          _info(movie.credits.directors.join(', '))
        ]),
        TableRow(children: [
          _label('Release'),
          _info(DateFormat.yMMMMd().format(movie.releaseDate)),
        ]),
      ],
    );
  }
}

class _Stars extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = Provider.of<Movie>(context);
    return Row(
      children: <Widget>[
        Text(movie.voteAverage.toString(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.yellow,
            )),
        SizedBox(width: 4),
        for (int i = 2; i <= 10; i += 2)
          Icon(_star(i - 2, i, movie.voteAverage),
              size: 18, color: Colors.yellow),
      ],
    );
  }

  IconData _star(int low, int high, double rating) {
    if (rating > high) {
      return Icons.star;
    } else if (rating > low) {
      return Icons.star_half;
    } else {
      return Icons.star_border;
    }
  }
}

class _Genres extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = Provider.of<Movie>(context);
    return Wrap(
      children: <Widget>[
        for (var genre in movie.genres) _genre(genre),
      ],
    );
  }

  Widget _genre(String text) {
    return Container(
      padding: EdgeInsets.fromLTRB(6, 4, 6, 3),
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(30),
        borderRadius: BorderRadius.all(Radius.circular(3)),
      ),
      child: Text(
        text.toUpperCase().trim(),
        style: TextStyle(
          fontSize: 9,
        ),
      ),
    );
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
