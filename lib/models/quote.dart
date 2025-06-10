import 'dart:math';

//add a spanishQuote child class, overriding getAlphabet and getNewQuote.
class Quote {
  final String ogQuote;
  final String cipherText; //should be uppercase
  final String plainText; //should be uppercase
  final Map<String, int> frequencies; // of plainText
  final Map<String, String> key; //plainText -> cipherText

  Quote({
    required this.ogQuote,
    required this.plainText,
    required this.key,
    required this.cipherText,
    required this.frequencies,
  });

  static List<String> getAlphabet() {
    return 'abcdefghijklmnopqrstuvwxyz'.toUpperCase().split('');
  }

  //takes in a single character
  static bool isException(String i) {
    return !getAlphabet().contains(i.toUpperCase());
  }

  static Map<String, String> generateKey(String text) {
    var alphabet = getAlphabet();
    var randomAlpha = getAlphabet();
    final rand = Random();
    var randVal = rand.nextInt(randomAlpha.length);
    Map<String, String> tempKey = {};

    for (int i = 0; i < alphabet.length; i++) {
      randVal = rand.nextInt(randomAlpha.length);
      while (randomAlpha[randVal] == alphabet[i]) {
        randVal = rand.nextInt(randomAlpha.length);
      }
      tempKey[alphabet[i]] = randomAlpha[randVal];
      randomAlpha.removeAt(randVal);
    }
    for (String i in text.split('')) {
      if (!alphabet.contains(i)) tempKey[i] = i;
    }
    return tempKey;
  }

  static String generateCipherText(String text, Map<String, String> tempKey) {
    String ans = "";
    for (String i in text.split('')) {
      ans += tempKey[i]!;
    }
    return ans;
  }

  static Map<String, int> getFrequencies(String text) {
    final Map<String, int> tempFrequencies = {};
    for (var char in text.split('')) {
      tempFrequencies[char] = (tempFrequencies[char] ?? 0) + 1;
    }
    return tempFrequencies;
  }

  //add functional quotes
  static Quote getNewQuote() {
    String tempOgQuote =
        "hello, world! What a wonderful time to be alive. Don't you think so?";
    String tempPlainText = tempOgQuote.toUpperCase();
    Map<String, String> tempKey = generateKey(tempPlainText);
    String tempCipherText = generateCipherText(tempPlainText, tempKey);
    Map<String, int> tempFrequencies = getFrequencies(tempPlainText);
    return Quote(
      ogQuote: tempOgQuote,
      plainText: tempPlainText,
      key: tempKey,
      cipherText: tempCipherText,
      frequencies: tempFrequencies,
    );
  }
}
