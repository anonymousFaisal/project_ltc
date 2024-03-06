import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_ltc/components/level_passed_card.dart';
import 'package:project_ltc/components/time_spent_card.dart';
import 'package:project_ltc/components/user_details.dart';
import 'profile_page.dart';
import 'package:project_ltc/animation/slide_animation.dart';

class ProfileScreenPage extends StatefulWidget {
  const ProfileScreenPage({super.key});

  @override
  State<ProfileScreenPage> createState() => _ProfileScreenPage();
}

class _ProfileScreenPage extends State<ProfileScreenPage>
    with TickerProviderStateMixin {
  final user = FirebaseAuth.instance.currentUser!;
  final userCollection = FirebaseFirestore.instance.collection("Users");

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: theme.primaryColor,
            expandedHeight: 200.0,
            pinned: true,
            shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Profile",
                style: TextStyle(
                  color: theme.textTheme.bodyMedium!.color,
                  letterSpacing: 2,
                  shadows: [
                    Shadow(
                      color: theme.colorScheme.onPrimary,
                      blurRadius: 5.0,
                      offset: const Offset(1.5, 1.5),
                    ),
                  ],
                ),
              ),
              titlePadding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.notifications, color: theme.iconTheme.color),
                onPressed: () {},
              ),
              SizedBox(width: 8),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  SlideAnimation(
                    direction: SlideDirection.right,
                    useOpacity: true,
                    customCurve: Curves.decelerate,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: theme.colorScheme.primary,
                            child: Icon(
                              Icons.person,
                              size: 40,
                              color: theme.secondaryHeaderColor,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: StreamBuilder<DocumentSnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("Users")
                                  .doc(user.email)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData && snapshot.data != null) {
                                  final userData = snapshot.data!.data()
                                      as Map<String, dynamic>;
                                  return UserDetails(userData: userData);
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              },
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: theme.iconTheme.color,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfilePage()),
                              );
                            },
                          ),
                          SizedBox(width: 8),
                        ],
                      ),
                    ),
                  ),
                  Divider(color: theme.dividerColor, thickness: 2),
                  const SizedBox(height: 20),
                  const Text(
                    'My Stats',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TimeSpentCard(),
                  const SizedBox(height: 15),
                  LevelPassedCard(),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
