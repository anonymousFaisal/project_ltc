import 'package:flutter/material.dart';
import 'package:project_ltc/levels/daily_quizzes/index.dart';

class DailyQuizzesPage extends StatefulWidget {
  @override
  _DailyQuizzesPageState createState() => _DailyQuizzesPageState();
}

class _DailyQuizzesPageState extends State<DailyQuizzesPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daily Quizzes',
          style: theme.textTheme.titleMedium,
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            quizTile('Quiz 1', theme),
            quizTile('Quiz 2', theme),
          ],
        ),
      ),
      backgroundColor: theme.colorScheme.background,
    );
  }

  Widget quizTile(String title, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        tileColor: theme.cardColor,
        title: Text(
          title,
          style: theme.textTheme.bodyMedium,
        ),
        trailing: Icon(Icons.arrow_forward, color: theme.iconTheme.color),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        onTap: () {
          if (title == 'Quiz 1') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Quiz1Page()),
            );
          }
          // Add more conditions for other quizzes if needed
        },
      ),
    );
  }
}
