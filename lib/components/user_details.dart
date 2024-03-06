import 'package:flutter/material.dart';

class UserDetails extends StatelessWidget {
  final Map<String, dynamic> userData;

  UserDetails({required this.userData});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final username = userData['username'] ?? 'Username';
    final aboutMe = userData['about me'] ?? 'About me content not available.';
    final profession = userData['profession'] ?? 'Unknown Profession';
    final institute = userData['institute'] ?? 'Unknown Institute';

    final textStyleLarge = TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.bold,
      color: theme.textTheme.bodyLarge!.color,
      letterSpacing: 1.2,
    );

    final textStyleMedium = TextStyle(
      fontSize: 20,
      fontStyle: FontStyle.italic,
      color: theme.textTheme.titleMedium!.color,
    );

    final textStyleSmall = TextStyle(
      fontSize: 16,
      color: theme.colorScheme.secondary,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Hi, $username", style: textStyleLarge),
          const SizedBox(height: 8),
          Text('$profession, $institute', style: textStyleSmall),
          const SizedBox(height: 10),
          Text('"$aboutMe"', style: textStyleMedium),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}