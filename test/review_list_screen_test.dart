
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wasty_reviews_app/models/review.dart';
import 'package:wasty_reviews_app/providers/review_provider.dart';
import 'package:wasty_reviews_app/screens/review_list_screen.dart';
import 'package:wasty_reviews_app/viewmodels/review_viewmodel.dart';
import 'package:wasty_reviews_app/widgets/review_card.dart';

void main() {
  testWidgets('ReviewListScreen shows multiple ReviewCards', (WidgetTester tester) async {
    // Prepare mock reviews for the test
    final reviews = [
      Review(id: '1', reviewer: 'Alex', text: 'Test', rating: 5, date: '2024-01-01'),
      Review(id: '2', reviewer: 'Eleni', text: 'Good', rating: 4, date: '2024-01-02'),
    ];

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          // Override the reviewViewModelProvider to return mock data
          reviewViewModelProvider.overrideWith((ref) {
            final viewModel = ReviewViewmodel(reviewRepository);
            viewModel.state = AsyncData(reviews); 
            return viewModel;
          })
        ],
        child: MaterialApp(
          home: Scaffold(
            body: ReviewListScreen(), // Widget under test
          ),
        ),
      ),
    );

    // Verify that two ReviewCards are shown
    expect(find.byType(ReviewCard), findsNWidgets(2));
    // Check that both reviewer names appear
    expect(find.text('Alex'), findsOneWidget);
    expect(find.text('Eleni'), findsOneWidget);
  });
}
