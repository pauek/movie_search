import 'package:flutter/material.dart';
import 'package:movie_search/api/tmdb.dart' as api;
import 'package:movie_search/model/movie.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _doSearch() {
    print('Has buscado: "${_controller.text}"');
    api.searchMovies(_controller.text).then((List<Movie> results) {
      results.forEach(print);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                filled: true,
                hintText: 'Star Wars',
              ),
              onSubmitted: (_) {
                _doSearch();
              },
            ),
            SizedBox(
              height: 4,
            ),
            FlatButton(
              onPressed: _doSearch,
              shape: StadiumBorder(),
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 12,
                ),
                child: Text(
                  'Search Movies',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
