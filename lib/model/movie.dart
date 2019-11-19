
class Actor {
  String name, character;
  int id, order;
  String profilePath;

  Actor.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        character = json['character'],
        id = json['id'],
        order = json['order'],
        profilePath = json['profile_path'];
}

class MovieCredits {
  List<String> genres;
  List<String> productionCountries;
  List<Actor> actors;
  List<String> directors, writers;

  void addMovieJson(Map<String, dynamic> json) {
    productionCountries = json['production_countries'].cast<String>();
  }

  void addCreditsJson(Map<String, dynamic> json) {
    actors = [];
    for (var actor in json['cast']) {
      actors.add(Actor.fromJson(actor));
    }
    directors = [];
    writers = [];
    for (var person in json['crew']) {
      if (person['job'] == 'Director') {
        directors.add(person['name']);
      }
    }
  }
}

class Movie {
  int id;
  String title, overview;
  String originalTitle, originalLanguage;
  String posterPath, backdropPath;
  DateTime releaseDate;
  List<String> genres;
  num popularity;
  int voteCount;
  num voteAverage;

  MovieCredits credits;

  Movie.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        overview = json['overview'],
        posterPath = json['poster_path'],
        backdropPath = json['backdrop_path'],
        popularity = json['popularity'],
        voteCount = json['vote_count'],
        voteAverage = json['vote_average'],
        originalTitle = json['original_title'],
        releaseDate = DateTime.parse(json['release_date']),
        originalLanguage = json['original_language'] {
          if (json.containsKey('genres')) {
            genres = json['genres'].map((g) => g['name']).cast<String>().toList();
          }
        }

  @override
  String toString() => 'Movie(id: $id, title: $title, posterPath: $posterPath)';
}


