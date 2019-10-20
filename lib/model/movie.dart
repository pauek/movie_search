class Movie {
  int id;
  String title, overview;
  String originalTitle, originalLanguage;
  String posterPath, backdropPath;
  DateTime releaseDate;
  List<int> genreIds;
  num popularity;
  int voteCount;
  num voteAverage;

  Movie.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        overview = json['overview'],
        posterPath = json['poster_path'],
        backdropPath = json['backdrop_path'],
        genreIds = json['genre_ids'].cast<int>(),
        popularity = json['popularity'],
        voteCount = json['vote_count'],
        voteAverage = json['vote_average'],
        originalTitle = json['original_title'],
        originalLanguage = json['original_language'];

  @override
  String toString() => 'Movie(id: $id, title: $title, posterPath: $posterPath)';
}

class Actor {
  String name;

  Actor.fromJson(Map<String, dynamic> json) : name = json['name'];
}
