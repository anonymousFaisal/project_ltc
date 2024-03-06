import 'package:flutter/material.dart';
import 'package:project_ltc/animation/progress_tracker.dart';

class JourneyCard extends StatelessWidget {
  final String title;
  final int completedLevels;
  final int totalLevels;
  final VoidCallback? onTap; // Add this line

  // Calculated progress
  double get progress => completedLevels / totalLevels.toDouble();

  JourneyCard({
    required this.title,
    required this.completedLevels,
    required this.totalLevels,
    this.onTap, // Add this line
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: const EdgeInsets.only(bottom: 16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: theme.textTheme.bodyLarge!.color,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "$completedLevels/$totalLevels Levels",
                      style: TextStyle(
                        fontSize: 15,
                        color: theme.secondaryHeaderColor,
                      ),
                    ),
                  ],
                ),
              ),
              ProgressAnimation(progress: progress),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward_ios,
                size: 24,
                color: theme.iconTheme.color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
