import 'package:shared_preferences/shared_preferences.dart';

import '../../data/mock_reviews.dart';
import '../../models/review.dart';

class ReviewRepository {
  // Local cache of review data, initially loaded from mock data.
  List<Review> _reviews = List<Review>.from(mockReviews);

  /// Fetches reviews, combining in-memory mock data with any locally saved
  /// replies, sentiment, and important flags stored in SharedPreferences.
  Future<List<Review>> fetchMockReviews() async {
    final prefs = await SharedPreferences.getInstance();

    // Update each review with locally saved data (if available)
    final updated =
        _reviews.map((review) {
          final reply = prefs.getString('reply_${review.id}') ?? review.reply;
          final isImportant =
              prefs.getBool('important_${review.id}') ?? review.isImportant;
          final sentiment =
              prefs.getString('sentiment_${review.id}') ?? review.sentiment;
          return review.copyWith(
            reply: reply,
            isImportant: isImportant,
            sentiment: sentiment,
          );
        }).toList();

    // Example: If fetching from a JSON server backend instead of local data
    /*
    final response = await http.get(Uri.parse('$baseUrl/reviews'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Review.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load reviews');
    }
    */

    return updated;
  }

  /// Sets the sentiment for a given review (by id) and persists it in local storage.
  Future<void> setSentiment(String reviewId, String sentiment) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('sentiment_$reviewId', sentiment);

    // Update in-memory cache as well
    final index = _reviews.indexWhere((r) => r.id == reviewId);
    if (index != -1) {
      _reviews[index] = _reviews[index].copyWith(sentiment: sentiment);
      _reviews = List<Review>.from(_reviews);
    }
  }

  /// Sets the reply text for a given review (by id) and persists it in local storage.
  Future<void> replyToReview(String reviewId, String reply) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('reply_$reviewId', reply);

    // Update in-memory cache as well
    final index = _reviews.indexWhere((r) => r.id == reviewId);
    if (index != -1) {
      _reviews[index] = _reviews[index].copyWith(reply: reply);
      _reviews = List<Review>.from(_reviews);
    }
  }

  /// Toggles the 'important' flag for a given review (by id) and persists the change in local storage.
  Future<void> toggleImportant(String reviewId) async {
    final prefs = await SharedPreferences.getInstance();

    final index = _reviews.indexWhere((r) => r.id == reviewId);
    if (index != -1) {
      final newImportant = !_reviews[index].isImportant;
      await prefs.setBool('important_$reviewId', newImportant);

      // Update in-memory cache as well
      _reviews[index] = _reviews[index].copyWith(
        isImportant: newImportant,
      );
      _reviews = List<Review>.from(_reviews);
    }
  }
}
