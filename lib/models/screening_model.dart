import 'dart:convert';

import 'package:atma_cinema/models/movie_model.dart';
import 'package:atma_cinema/models/studio_model.dart';

class ScreeningModel {
  final String screeningID;
  final MovieModel movie;
  final StudioModel studio;
  final Map<String, dynamic> seatLayout;
  final DateTime date;
  final String time;
  final double price;

  ScreeningModel({
    required this.screeningID,
    required this.movie,
    required this.studio,
    required this.seatLayout,
    required this.date,
    required this.time,
    required this.price,
  });

  factory ScreeningModel.fromJson(Map<String, dynamic> json) {
    return ScreeningModel(
      screeningID: json['screeningID'],
      movie: MovieModel.fromJson(json['movie']),
      studio: StudioModel.fromJson(json['studio']),
      seatLayout: json['seatLayout'] is String
          ? jsonDecode(json['seatLayout'])
          : json['seatLayout'],
      date: DateTime.parse(json['date']),
      time: json['time'],
      price: double.parse(json['price'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'screeningID': screeningID,
      'movieID': movie.movieID,
      'studioID': studio.studioID,
      'seatLayout': jsonEncode(seatLayout),
      'date': date.toIso8601String(),
      'time': time,
      'price': price,
    };
  }
}
