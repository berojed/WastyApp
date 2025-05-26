import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wasty_reviews_app/models/review.dart';
import 'package:wasty_reviews_app/providers/review_provider.dart';
import 'package:wasty_reviews_app/screens/analytics_screen.dart';
import 'package:wasty_reviews_app/viewmodels/review_viewmodel.dart';

// This test checks if AnalyticsScreen displays review count and sentiment counts correctly.
// NOTE: If you see a RenderFlex overflow error in the test output, 
// it's usually because there isn't enough vertical space for all widgets.
// For widget tests, wrap your test widget in a SizedBox or use MaterialApp without Scaffold/body 
// if only testing text widgets, or set MediaQuery for sufficient height.

void main() {
  testWidgets('AnalyticsScreen shows number of reviews and sentiment count', (WidgetTester tester) async {
    // Dummy review data for test
    final reviews = [
      Review(id: '1', reviewer: 'Alex', text: 'Great', rating: 5, date: '2024-01-01', sentiment: 'Positive'),
      Review(id: '2', reviewer: 'Eleni', text: 'Bad', rating: 2, date: '2024-01-02', sentiment: 'Negative'),
    ];

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          // Inject mock viewmodel so test doesn't rely on real providers
          reviewViewModelProvider.overrideWith((ref) {
            final viewModel = ReviewViewmodel(reviewRepository);
            viewModel.state = AsyncData(reviews); 
            return viewModel;
          }),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: AnalyticsScreen(), // Screen under test
          ),
        ),
      ),
    );

    // Check that expected texts are shown
    expect(find.textContaining('Total reviews: 2'), findsOneWidget);
    expect(find.textContaining('Positive: 1'), findsOneWidget);
    expect(find.textContaining('Negative: 1'), findsOneWidget);
  });
}
