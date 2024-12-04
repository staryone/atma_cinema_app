class ReviewModel {
  final String reviewID;
  final String userID;
  final String movieID;
  final String? comment;
  final int rating;
  final DateTime reviewDate;

  ReviewModel({
    required this.reviewID,
    required this.userID,
    required this.movieID,
    this.comment,
    required this.rating,
    required this.reviewDate,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      reviewID: json['reviewID'] as String,
      userID: json['userID'] as String,
      movieID: json['movieID'] as String,
      comment: json['comment'] as String?,
      rating: json['rating'] as int,
      reviewDate: DateTime.parse(json['reviewDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reviewID': reviewID,
      'userID': userID,
      'movieID': movieID,
      'comment': comment,
      'rating': rating,
      'reviewDate': reviewDate.toIso8601String(),
    };
  }
}
