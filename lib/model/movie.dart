class Movie {
  String title;

  Movie.fromJson(Map<String, dynamic> json) : title = json['title'];

  @override
  String toString() => 'Movie(title: $title)';
}

class Actor {
  String name;

  Actor.fromJson(Map<String, dynamic> json) : name = json['name'];
}
