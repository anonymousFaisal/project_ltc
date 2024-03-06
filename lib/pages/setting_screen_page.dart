import 'package:flutter/material.dart';
import 'package:project_ltc/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
          },
          child: Text('Switch Theme'),
        ),
      ),
    );
  }
}
