import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/review.dart';
import '../providers/review_provider.dart';
import 'reply_dialog.dart';

class ReviewCard extends ConsumerWidget {
  final Review review;

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAdmin = ref.watch(adminModeProvider);
   

    return Card(
      child: ListTile(
        title: Text(review.reviewer),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${review.rating} ★  ${review.date}'),
            Text(review.text),
            if (review.reply != null)
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  'Reply: ${review.reply}',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            Row(
              children: [
                TextButton(
                  child: Text("Positive"),
                  onPressed:
                      () => ref
                          .read(reviewViewModelProvider.notifier)
                          .setSentiment(review.id, "Positive"),
                ),
                TextButton(
                  child: Text("Neutral"),
                  onPressed:
                      () => ref
                          .read(reviewViewModelProvider.notifier)
                          .setSentiment(review.id, "Neutral"),
                ),
                TextButton(
                  child: Text("Negative"),
                  onPressed:
                      () => ref
                          .read(reviewViewModelProvider.notifier)
                          .setSentiment(review.id, "Negative"),
                ),
                IconButton(
                  icon: Icon(
                    review.isImportant ? Icons.star : Icons.star_border,
                    color: review.isImportant ? Colors.yellow : Colors.grey,
                  ),
                  onPressed:
                      () => ref
                          .read(reviewViewModelProvider.notifier)
                          .toggleImportant(review.id),
                ),
                if (isAdmin)
                  IconButton(
                    icon: Icon(Icons.reply),
                    onPressed: () async {
                      final reply = await showDialog<String>(
                        context: context,
                        builder: (context) => ReplyDialog(),
                      );
                      if (reply != null && reply.trim().isNotEmpty) {
                        ref
                            .read(reviewViewModelProvider.notifier)
                            .replyToReview(review.id, reply);
                      }
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
