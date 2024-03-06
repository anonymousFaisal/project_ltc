import 'package:flutter/material.dart';

class AdvancedPage extends StatefulWidget {
  @override
  _AdvancedPageState createState() => _AdvancedPageState();
}

class _AdvancedPageState extends State<AdvancedPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Advanced', style: theme.textTheme.titleMedium),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            topicTile('Advanced Algorithms', theme),
            topicTile('System Design', theme),
          ],
        ),
      ),
      backgroundColor: theme.colorScheme.background,
    );
  }

  Widget topicTile(String title, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        tileColor: theme.cardColor,
        title: Text(title, style: theme.textTheme.bodyMedium),
        trailing: Icon(Icons.arrow_forward, color: theme.iconTheme.color),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
