import 'package:flutter/material.dart';

class DrillProgressIndicator extends StatelessWidget {
  final int currentIndex;
  final int total;

  const DrillProgressIndicator({
    super.key,
    required this.currentIndex,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final bool isComplete = currentIndex >= total;
    final double progress = total > 0
        ? (isComplete ? 1.0 : currentIndex / total)
        : 0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Column(
        children: [
          LinearProgressIndicator(
            value: progress,
            color: Colors.green,
            backgroundColor: Colors.green[100],
            minHeight: 8,
          ),
          const SizedBox(height: 4),
          Text(
            isComplete
                ? 'All Drills Complete!'
                : '$currentIndex / $total completed',
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}