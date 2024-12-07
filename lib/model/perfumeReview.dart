import 'package:cloud_firestore/cloud_firestore.dart';

class PerfumeReview {
  String name;
  String brand;
  String reviewerId;
  String reviewerUsername;
  String genre;
  String season;
  int overallRating;
  String occasion;
  Timestamp reviewDate;
  String longevity;
  String sillage;
  String comment;

  PerfumeReview({
    required this.name,
    required this.brand,
    required this.genre,
    required this.season,
    required this.overallRating,
    required this.occasion,
    required this.reviewerId,
    required this.reviewerUsername,
    required this.reviewDate,
    required this.longevity,
    required this.sillage,
    required this.comment,
  });

  PerfumeReview.fromJson(Map<String, Object?> json)
      : this(
          name: json['name']! as String,
          brand: json['brand']! as String,
          reviewerId: json['reviewerId']! as String,
          reviewerUsername: json['reviewerUsername']! as String,
          genre: json['genre']! as String,
          season: json['season']! as String,
          overallRating: json['overallRating']! as int,
          occasion: json['occasion']! as String,
          reviewDate: json['reviewDate']! as Timestamp,
          longevity: json['longevity']! as String,
          sillage: json['sillage']! as String,
          comment: json['comment']! as String,
        );

  PerfumeReview copyWith({
    String? name,
    String? brand,
    String? reviewerId,
    String? reviewerUsername,
    String? genre,
    String? season,
    int? overallRating,
    String? occasion,
    Timestamp? reviewDate,
    String? longevity,
    String? sillage,
    String? comment,
  }) {
    return PerfumeReview(
      name: name ?? this.name,
      brand: brand ?? this.brand,
      reviewerId: reviewerId ?? this.reviewerId,
      reviewerUsername: reviewerUsername ?? this.reviewerUsername,
      genre: genre ?? this.genre,
      season: season ?? this.season,
      overallRating: overallRating ?? this.overallRating,
      occasion: occasion ?? this.occasion,
      reviewDate: reviewDate ?? this.reviewDate,
      longevity: longevity ?? this.longevity,
      sillage: sillage ?? this.sillage,
      comment: comment ?? this.comment,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'brand': brand,
      'reviewerId': reviewerId,
      'reviewerUsername': reviewerUsername,
      'genre': genre,
      'season': season,
      'overallRating': overallRating,
      'occasion': occasion,
      'reviewDate': reviewDate,
      'longevity': longevity,
      'sillage': sillage,
      'comment': comment,
    };
  }

  factory PerfumeReview.fromMap(Map<String, dynamic> data) {
    return PerfumeReview(
      name: data['name'] ?? '',
      brand: data['brand'] ?? '',
      reviewerId: data['reviewerId'] ?? '',
      reviewerUsername: data['reviewerUsername'] ?? '',
      genre: data['genre'] ?? '',
      season: data['season'] ?? '',
      overallRating: data['overallRating'] ?? 0,
      occasion: data['occasion'] ?? '',
      reviewDate: data['reviewDate'] ?? Timestamp.now(),
      longevity: data['longevity'] ?? '',
      sillage: data['sillage'] ?? '',
      comment: data['comment'] ?? '',
    );
  }
}
