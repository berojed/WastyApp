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
  int? selectedRating;

  @override
  Widget build(BuildContext context) {
    final reviewsAsync = ref.watch(reviewViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        actions: [
          DropdownButton<int?>(
            value: selectedRating,
            hint: const Text("All Ratings"),
            items: [
              const DropdownMenuItem(value: null, child: Text('All')),
              for (int i = 5; i >= 1; i--)
                DropdownMenuItem(value: i, child: Text('$i ★')),
            ],
            //I used setState here because I won`t need it in other screens/classes
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
          final filtered = selectedRating == null
              ? reviews
              : reviews.where((r) => r.rating == selectedRating).toList();

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
