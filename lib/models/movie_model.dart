class MovieModel {
  final String movieID;
  final String movieTitle;
  final int duration;
  final String? synopsis;
  final String director;
  final String? writers;
  final String ageRating;
  final String genre;
  final String? cover;
  final String? trailer;

  // Constructor
  MovieModel({
    required this.movieID,
    required this.movieTitle,
    required this.duration,
    this.synopsis,
    required this.director,
    this.writers,
    required this.ageRating,
    required this.genre,
    this.cover,
    this.trailer,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      movieID: json['movieID'] as String,
      movieTitle: json['movieTitle'] as String,
      duration: json['duration'] as int,
      synopsis: json['synopsis'] as String?,
      director: json['director'] as String,
      writers: json['writers'] as String?,
      ageRating: json['ageRating'] as String,
      genre: json['genre'] as String,
      cover: json['cover'] as String?,
      trailer: json['trailer'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'movieID': movieID,
      'movieTitle': movieTitle,
      'duration': duration,
      'synopsis': synopsis,
      'director': director,
      'writers': writers,
      'ageRating': ageRating,
      'genre': genre,
      'cover': cover,
      'trailer': trailer,
    };
  }
}
