class QuoteStats {
  final double avgSolveTimeAll;
  final double avgSolveTimeThisWeek;
  final double avgSolveTimeLastWeek;
  final double fastestSolveTimeAll;
  final double fastestSolveTimeThisWeek;
  final double fastestSolveTimeLastWeek;
  final int totalSolvedAll;
  final int totalSolvedThisWeek;
  final int totalSolvedLastWeek;

  QuoteStats({
    required this.avgSolveTimeAll,
    required this.avgSolveTimeThisWeek,
    required this.avgSolveTimeLastWeek,
    required this.fastestSolveTimeAll,
    required this.fastestSolveTimeThisWeek,
    required this.fastestSolveTimeLastWeek,
    required this.totalSolvedAll,
    required this.totalSolvedThisWeek,
    required this.totalSolvedLastWeek,
  });
}
