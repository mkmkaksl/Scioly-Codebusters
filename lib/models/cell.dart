class Cell {
  final String text; //user entered letter
  final String cipher; //displayed cryptogram letter
  final bool isLit;
  final bool isDuplicate;
  final bool isSelected;
  final bool isException;
  final bool isCorrect;
  final int count;

  Cell({
    required this.text,
    required this.cipher,
    required this.isException,
    this.isLit = false,
    this.isDuplicate = false,
    this.isSelected = false,
    this.isCorrect = false,
    this.count = 0,
  });

  Cell copyWith({
    String? text,
    String? cipher,
    bool? isException,
    bool? isLit,
    bool? isDuplicate,
    bool? isSelected,
    bool? isCorrect,
    int? count,
  }) {
    return Cell(
      text: text ?? this.text,
      cipher: cipher ?? this.cipher,
      isException: isException ?? this.isException,
      isLit: isLit ?? this.isLit,
      isDuplicate: isDuplicate ?? this.isDuplicate,
      isSelected: isSelected ?? this.isSelected,
      isCorrect: isCorrect ?? this.isCorrect,
      count: count ?? this.count,
    );
  }
}
