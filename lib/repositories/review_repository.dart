import 'package:shared_preferences/shared_preferences.dart';

import '../../data/mock_reviews.dart';
import '../../models/review.dart';

class ReviewRepository {
  List<Review> _reviews = List<Review>.from(mockReviews);

  Future<List<Review>> fetchMockReviews() async {
    final prefs = await SharedPreferences.getInstance();

    // Map every review so that we can pull locally saved data(if there is any)
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

    //If I wanted to store reviews on json server and fetch data from it(using http package):
    /*
        final response = await http.get(Uri.parse('$baseUrl/reviews'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Review.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load reviews');
    }
  }
  */

    return updated;
  }

  Future<void> setSentiment(String reviewId, String sentiment) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('sentiment_$reviewId', sentiment);

    final index = _reviews.indexWhere((r) => r.id == reviewId);
    if (index != -1) {
      _reviews[index] = _reviews[index].copyWith(sentiment: sentiment);
      _reviews = List<Review>.from(_reviews);
    }
  }

  Future<void> replyToReview(String reviewId, String reply) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('reply_$reviewId', reply);

    final index = _reviews.indexWhere((r) => r.id == reviewId);
    if (index != -1) {
      _reviews[index] = _reviews[index].copyWith(reply: reply);
      _reviews = List<Review>.from(_reviews);
    }
  }

  Future<void> toggleImportant(String reviewId) async {
    final prefs = await SharedPreferences.getInstance();

    final index = _reviews.indexWhere((r) => r.id == reviewId);
    if (index != -1) {
      final newImportant = !_reviews[index].isImportant;
      await prefs.setBool('important_$reviewId', newImportant);

      _reviews[index] = _reviews[index].copyWith(
        isImportant: !_reviews[index].isImportant,
      );
      _reviews = List<Review>.from(_reviews);
    }
  }
}
