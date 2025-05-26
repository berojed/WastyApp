import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/review_provider.dart';
import '../../widgets/review_card.dart';


class ReviewListScreen extends ConsumerStatefulWidget {
  const ReviewListScreen({super.key});

  @override
  ConsumerState<ReviewListScreen> createState() => _ReviewListScreenState();
}

class _ReviewListScreenState extends ConsumerState<ReviewListScreen> {
  // Holds the currently selected rating filter (null = show all)
  int? selectedRating;

  @override
  Widget build(BuildContext context) {
    // Watch reviews list (provider)
    final reviewsAsync = ref.watch(reviewViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        actions: [
          // Dropdown for filtering reviews by rating
          DropdownButton<int?>(
            value: selectedRating,
            hint: const Text("All Ratings"),
            items: [
              const DropdownMenuItem(value: null, child: Text('All')),
              for (int i = 5; i >= 1; i--)
                DropdownMenuItem(value: i, child: Text('$i ★')),
            ],
            //  I  used setState here to update filter within this screen only
            onChanged: (val) {
              setState(() {
                selectedRating = val;
              });
            },
          ),
        ],
      ),
      body: reviewsAsync.when(
        data: (reviews) {
          // Apply selected rating filter, or show all if no filter selected
          final filtered = selectedRating == null
              ? reviews
              : reviews.where((r) => r.rating == selectedRating).toList();

          // Build list of ReviewCards for filtered reviews
          return ListView.builder(
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              return ReviewCard(review: filtered[index]);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
