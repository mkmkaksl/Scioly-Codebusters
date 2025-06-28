import 'package:flutter/material.dart';
import 'package:projects/library.dart';

// Assume PatternMap and getPatternKey are defined elsewhere and imported

class DictionaryWidget extends StatelessWidget {
  const DictionaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final entries = dictionary.map.entries.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Pattern Map')),
      body: Scrollbar(
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: entries.length,
          separatorBuilder: (_, _) => const SizedBox(height: 24),
          itemBuilder: (context, index) {
            final entry = entries[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.key,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: entry.value
                      .map((word) => Chip(label: Text(word)))
                      .toList(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
