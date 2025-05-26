import 'package:riverpod/riverpod.dart';

import '../models/review.dart';
import '../repositories/review_repository.dart';


class ReviewViewmodel extends StateNotifier<AsyncValue<List<Review>>> {
  final ReviewRepository repository;

  ReviewViewmodel(this.repository) : super(const AsyncValue.loading()) {
    loadReviews();
  }

  Future<void> loadReviews() async {
    try {
      final reviews = await repository.fetchMockReviews();  
      state = AsyncData(reviews);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> setSentiment(String reviewId, String sentiment) async {
    await repository.setSentiment(reviewId, sentiment);
    await loadReviews();
  }

  Future<void> replyToReview(String reviewId, String reply) async {
    await repository.replyToReview(reviewId, reply);
    await loadReviews();
  }

  Future<void> toggleImportant(String reviewId) async {

    await repository.toggleImportant(reviewId);
    await loadReviews();
  }
}
