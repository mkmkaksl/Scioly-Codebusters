import 'package:projects/library.dart';
import 'package:flutter/material.dart';

class QuoteCard extends StatelessWidget {
  final SolvedQuote quote;
  final VoidCallback onFavoriteToggle;

  const QuoteCard({
    super.key,
    required this.quote,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(quote.text),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('\n- ${quote.author}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: List.generate(
                    quote.rating,
                    (index) => Icon(Icons.star, color: Colors.amber, size: 16),
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.timer, size: 16),
                    Text('${quote.solveTime}s'),
                  ],
                ),
                Text(quote.gameMode),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(
            quote.isFavorite ? Icons.favorite : Icons.favorite_border,
            color: quote.isFavorite ? Colors.red : Colors.grey,
          ),
          onPressed: onFavoriteToggle,
        ),
      ),
    );
  }
}
