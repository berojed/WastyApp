import 'package:riverpod/riverpod.dart';

import '../models/review.dart';
import '../repositories/review_repository.dart';


/// ViewModel for managing the state of reviews using Riverpod's StateNotifier.
/// Handles loading reviews, updating sentiment, replies, and importance.
class ReviewViewmodel extends StateNotifier<AsyncValue<List<Review>>> {
  final ReviewRepository repository;

  /// Initializes the viewmodel and loads reviews on creation.
  ReviewViewmodel(this.repository) : super(const AsyncValue.loading()) {
    loadReviews();
  }

  /// Loads the list of reviews from the repository and updates the state.
  Future<void> loadReviews() async {
    try {
      final reviews = await repository.fetchMockReviews();  
      state = AsyncData(reviews);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  /// Sets the sentiment for a review and reloads the reviews state.
  Future<void> setSentiment(String reviewId, String sentiment) async {
    await repository.setSentiment(reviewId, sentiment);
    await loadReviews();
  }

  /// Adds or updates a reply for a review and reloads the reviews state.
  Future<void> replyToReview(String reviewId, String reply) async {
    await repository.replyToReview(reviewId, reply);
    await loadReviews();
  }

  /// Toggles the important flag for a review and reloads the reviews state.
  Future<void> toggleImportant(String reviewId) async {
    await repository.toggleImportant(reviewId);
    await loadReviews();
  }
}
