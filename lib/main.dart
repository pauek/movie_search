import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_search/pages/results_page.dart';
import 'package:movie_search/pages/search_page.dart';

setDarkSystemNavigationBar() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: Colors.black,
    ),
  );
}

Future<void> main() async {
  await DotEnv().load('.env');
  setDarkSystemNavigationBar();
  runApp(MovieSearchAp());
}

class MovieSearchAp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      routes: {
        '/search': (_) => SearchPage(),
        '/results': (_) => ResultsPage(),
      },
      initialRoute: '/search',
    );
  }
}
