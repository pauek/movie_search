import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_search/pages/search_page.dart';

Future<void> main() async {
  await DotEnv().load('.env');
  runApp(MovieSearchAp());
}

class MovieSearchAp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        '/search': (_) => SearchPage(),
      },
      initialRoute: '/search',
    );
  }
}
