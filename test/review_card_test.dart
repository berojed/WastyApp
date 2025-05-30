import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasty_reviews_app/models/review.dart';
import 'package:wasty_reviews_app/providers/review_provider.dart';
import 'package:wasty_reviews_app/widgets/review_card.dart';

void main() {
  testWidgets('ReviewCard shows review name and reply button for admin', (WidgetTester tester) async {
    // Create a dummy review to display
    final review = Review(
      id: '1',
      reviewer: 'Alexandros',
      text: 'Great!',
      rating: 5,
      date: '2024-05-10',
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          // Override adminModeProvider to true so reply button should be visible
          adminModeProvider.overrideWith((ref) => true),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: ReviewCard(review: review),
          ),
        ),
      ),
    );

    // Check if the reviewer's name is displayed
    expect(find.text('Alexandros'), findsOneWidget);

    // Check if the reply icon button is shown for admin mode
    expect(find.byIcon(Icons.reply), findsOneWidget);
  });
}
