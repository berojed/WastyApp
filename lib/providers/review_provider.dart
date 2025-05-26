import 'package:riverpod/riverpod.dart';

import '../../models/review.dart';
import '../../repositories/review_repository.dart';
import '../../viewmodels/review_viewmodel.dart';

final reviewRepository= ReviewRepository(); 

final reviewRepositoryProvider = Provider<ReviewRepository>((ref) => reviewRepository);

final reviewViewModelProvider =
    StateNotifierProvider<ReviewViewmodel, AsyncValue<List<Review>>>(
  (ref) => ReviewViewmodel(ref.watch(reviewRepositoryProvider)),
);

final adminModeProvider = StateProvider<bool>((ref) => true);
