import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part '../models/stats.g.dart';

class StatsGrid extends StatelessWidget {
  final String widgetKey;
  final double fastestAllTime;
  final double averageAllTime;
  final double fastestLast10;
  final double averageLast10;
  final double fastestPrevious10;
  final double averagePrevious10;

  const StatsGrid({
    super.key,
    required this.widgetKey,
    required this.fastestAllTime,
    required this.averageAllTime,
    required this.fastestLast10,
    required this.averageLast10,
    required this.fastestPrevious10,
    required this.averagePrevious10,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Solve Statistics - $widgetKey')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Table(
            border: TableBorder.all(color: Colors.grey),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              // Header row
              TableRow(
                children: [
                  const SizedBox(), // Empty top-left cell
                  _buildHeaderCell('All Time'),
                  _buildHeaderCell('Last 10'),
                  _buildHeaderCell('Previous 10'),
                ],
              ),
              // Fastest row
              TableRow(
                children: [
                  _buildRowHeaderCell('Fastest'),
                  _buildDataCell(fastestAllTime),
                  _buildDataCell(fastestLast10),
                  _buildDataCell(fastestPrevious10),
                ],
              ),
              // Average row
              TableRow(
                children: [
                  _buildRowHeaderCell('Average'),
                  _buildDataCell(averageAllTime),
                  _buildDataCell(averageLast10),
                  _buildDataCell(averagePrevious10),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildRowHeaderCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildDataCell(double time) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('${time.toStringAsFixed(2)}s', textAlign: TextAlign.center),
    );
  }
}

@HiveType(typeId: 0)
class SolveRecord {
  @HiveField(0)
  final double solveTime;

  @HiveField(1)
  final DateTime timestamp;

  SolveRecord({required this.solveTime, required this.timestamp});
}

@HiveType(typeId: 1)
class GameModeStats {
  @HiveField(0)
  final List<SolveRecord> solveRecords;

  GameModeStats({required this.solveRecords});

  double get fastestSolve => solveRecords.isEmpty
      ? 0
      : solveRecords.map((r) => r.solveTime).reduce((a, b) => a < b ? a : b);

  double get averageSolve => solveRecords.isEmpty
      ? 0
      : solveRecords.map((r) => r.solveTime).reduce((a, b) => a + b) /
            solveRecords.length;

  double fastestInLast(int count, {int skip = 0}) {
    if (solveRecords.isEmpty) return 0;
    final lastN = solveRecords.skip(skip).take(count).toList();
    if (lastN.isEmpty) return 0;
    return lastN.map((r) => r.solveTime).reduce((a, b) => a < b ? a : b);
  }

  double averageInLast(int count, {int skip = 0}) {
    if (solveRecords.isEmpty) return 0;
    final lastN = solveRecords.skip(skip).take(count).toList();
    if (lastN.isEmpty) return 0;
    return lastN.map((r) => r.solveTime).reduce((a, b) => a + b) / lastN.length;
  }

  void addSolve(double time) {
    solveRecords.insert(
      0,
      SolveRecord(solveTime: time, timestamp: DateTime.now()),
    );
  }
}
