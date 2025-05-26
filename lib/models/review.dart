import 'dart:core';

class Review {
  final String reviewer;
  final String id;
  final String text;
  final int rating;
  final String date;
  String? reply;
  String sentiment;
  bool isImportant;

  Review({
    required this.id,
    required this.reviewer,
    required this.text,
    required this.rating,
    required this.date,
    this.reply,
    this.sentiment = "Neutral",
    this.isImportant = false,
  });

  //This method will make it easier to create new instances of objects with changed values, while others stay the same
  //For example, if we just want to change sentiment property in instance of object:
  //final updatedReview = review.copyWith(sentiment: "Negative");

  Review copyWith({
    String? reviewer,
    String? id,
    String? text,
    int? rating,
    String? date,
    String? reply,
    String? sentiment,
    bool? isImportant,
  }) {
    return Review(
      id: id ?? this.id,
      reviewer: reviewer ?? this.reviewer,
      text: text ?? this.text,
      rating: rating ?? this.rating,
      date: date ?? this.date,
      reply: reply ?? this.reply,
      sentiment: sentiment ?? this.sentiment,
      isImportant: isImportant ?? this.isImportant,
    );
  }

  //This method will help convert json to Review object, use case will look something like this:
  //final review = Review.fromJson(json);
  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json['id'],
    reviewer: json['reviewer'],
    rating: json['rating'],
    date: json['date'],
    text: json['text'],
    reply: json['reply'],
    sentiment: json['sentiment'] ?? "Neutral",
    isImportant: json['isImportant'] ?? false,
  );

  //This method will help convert Review object to json , use case will look something like this:
  //final json = review.toJson();
  Map<String, dynamic> toJson() => {
    'id': id,
    'reviewer': reviewer,
    'rating': rating,
    'date': date,
    'text': text,
    'reply': reply,
    'sentiment': sentiment,
    'isImportant': isImportant,
  };
}
