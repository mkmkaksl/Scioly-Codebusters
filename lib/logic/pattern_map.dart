import 'dart:collection';

// Function to generate a pattern key for a word (e.g., 'mom' -> 'ABA')
String getPatternKey(String word) {
  Map<String, String> letterMap = {};
  int nextCharCode = 'A'.codeUnitAt(0);
  StringBuffer pattern = StringBuffer();

  for (var ch in word.toLowerCase().split('')) {
    if (!letterMap.containsKey(ch)) {
      letterMap[ch] = String.fromCharCode(nextCharCode++);
    }
    pattern.write(letterMap[ch]);
  }
  return pattern.toString();
}

// SortedMap by key length, then lexicographically
class PatternMap {
  final SplayTreeMap<String, List<String>> _map = SplayTreeMap(
    (a, b) =>
        a.length == b.length ? a.compareTo(b) : a.length.compareTo(b.length),
  );

  void addWord(String word) {
    final key = getPatternKey(word);
    _map.putIfAbsent(key, () => []);
    // Insert word in sorted order
    final list = _map[key]!;
    int idx = list.indexWhere((w) => word.compareTo(w) < 0);
    if (idx == -1) {
      list.add(word);
    } else {
      list.insert(idx, word);
    }
  }

  Map<String, List<String>> get map => _map;
}
