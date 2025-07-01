import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/library.dart';
import 'package:flutter/material.dart';

class AllQuotesTab extends ConsumerWidget {
  const AllQuotesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quotes = ref.watch(quoteListProvider);

    return ListView.builder(
      itemCount: quotes.length,
      itemBuilder: (context, index) {
        final quote = quotes[index];
        return QuoteCard(
          quote: quote,
          onFavoriteToggle: () =>
              ref.read(quoteListProvider.notifier).toggleFavorite(index),
        );
      },
    );
  }
}
