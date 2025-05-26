import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wasty_reviews_app/models/review.dart';
import 'package:wasty_reviews_app/providers/review_provider.dart';
import 'package:wasty_reviews_app/screens/analytics_screen.dart';
import 'package:wasty_reviews_app/viewmodels/review_viewmodel.dart';

//This test has failed because of this exception caught by rendering library: The following assertion was thrown during layout:
//A RenderFlex overflowed by 10.0 pixels on the bottom.
void main()
{
  testWidgets('AnalyticsScreen shows number of reviews and sentiment count', (WidgetTester tester) async {
  final reviews = [
    Review(id: '1', reviewer: 'Alex', text: 'Great', rating: 5, date: '2024-01-01', sentiment: 'Positive'),
    Review(id: '2', reviewer: 'Eleni', text: 'Bad', rating: 2, date: '2024-01-02', sentiment: 'Negative'),
  ];

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
            reviewViewModelProvider.overrideWith((ref) {

  final viewModel = ReviewViewmodel(reviewRepository);
  viewModel.state = AsyncData(reviews); 
  return viewModel;
})
      ],
      child: MaterialApp(
        home: Scaffold(
          body: AnalyticsScreen(),
        ),
      ),
    ),
  );

  expect(find.textContaining('Total reviews: 2'), findsOneWidget);
  expect(find.textContaining('Positive: 1'), findsOneWidget);
  expect(find.textContaining('Negative: 1'), findsOneWidget);
});

}