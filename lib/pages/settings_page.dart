import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_ltc/pages/setting_screen_page.dart';
import 'profile_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 200),
            Card(
              color: theme.cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  color: theme.iconTheme.color,
                  size: 30,
                ),
                title: Text(
                  'Profile',
                  style: TextStyle(
                    color: theme.textTheme.bodyMedium!.color,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  // Navigate to Profile Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              color: theme.cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              child: ListTile(
                leading: Icon(
                  Icons.settings,
                  color: theme.iconTheme.color,
                  size: 30,
                ),
                title: Text(
                  'Settings',
                  style: TextStyle(
                    color:  theme.textTheme.bodyMedium!.color,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  // Navigate to the settings page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsScreenPage()),
                  );
                },
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              color: theme.cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              child: ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  color: theme.iconTheme.color,
                  size: 30,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(
                    color:  theme.textTheme.bodyMedium!.color,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () async {
                  signUserOut();
                },
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
