import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasty_reviews_app/providers/review_provider.dart';
import 'package:wasty_reviews_app/widgets/analytics_chart.dart';
class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the reviews state (from viewmodel/provider)
    final reviewsAsync = ref.watch(reviewViewModelProvider);

    return Scaffold(
      body: reviewsAsync.when(
        data: (reviews) {
          // Helper functions for analytics counts, I should not have placed logic in view
          int countBySentiment(String sentiment) =>
              reviews.where((r) => r.sentiment == sentiment).length;
          int countImportant() => reviews.where((r) => r.isImportant).length;

          return Column(
            children: [
              // Key metrics displayed in text
              Text("Total reviews: ${reviews.length}"),
              Text("Positive: ${countBySentiment("Positive")}"),
              Text("Neutral: ${countBySentiment("Neutral")}"),
              Text("Negative: ${countBySentiment("Negative")}"),
              Text("Important: ${countImportant()}"),
              Padding(padding: EdgeInsets.all(30)),
              // Chart for visual analytics
              AnalyticsChart(reviews: reviews),
            ],
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
