import 'package:flutter/material.dart';
import 'package:project_ltc/animation/slide_animation.dart';
import 'package:project_ltc/levels/index.dart';

class LevelPage extends StatefulWidget {
  const LevelPage({Key? key}) : super(key: key);

  @override
  State<LevelPage> createState() => _LevelPageState();
}

class _LevelPageState extends State<LevelPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: theme.primaryColor,
            expandedHeight: 200,
            floating: false,
            pinned: true,
            elevation: 10.0,
            shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'CODING LEVELS',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3.0,
                  color: theme.textTheme.bodyMedium!.color,
                  shadows: [
                    Shadow(
                      color: theme.colorScheme.onPrimary,
                      blurRadius: 5.0,
                      offset: const Offset(1.5, 1.5),
                    ),
                  ],
                ),
              ),
              centerTitle: true,
              collapseMode: CollapseMode.parallax,
            ),
          ),

          // Daily Quizzes
          buildSectionItem(
            context: context,
            title: 'Daily Quizzes',
            alignment: TextAlign.right,
            direction: SlideDirection.left,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DailyQuizzesPage()),
              );
            },
          ),

          // Beginner
          buildSectionItem(
            context: context,
            title: 'Beginner',
            alignment: TextAlign.left,
            direction: SlideDirection.right,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BeginnerPage()),
              );
            },
          ),

          // Intermediate
          buildSectionItem(
            context: context,
            title: 'Intermediate',
            alignment: TextAlign.right,
            direction: SlideDirection.left,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => IntermediatePage()),
              );
            },
          ),

          // Advanced
          buildSectionItem(
            context: context,
            title: 'Advanced',
            alignment: TextAlign.left,
            direction: SlideDirection.right,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdvancedPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  // Card Details
  Widget buildSectionItem({
    required BuildContext context,
    required String title,
    required TextAlign alignment,
    required SlideDirection direction,
    void Function()? onTap,
  }) {
    final theme = Theme.of(context);

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
        child: InkWell(
          onTap: onTap,
          child: SlideAnimation(
            direction: direction,
            useOpacity: false,
            customCurve: Curves.easeOutQuint,
            child: Container(
              height: 180,
              decoration: BoxDecoration(
                color: theme.primaryColorDark.withOpacity(0.7),
                borderRadius: BorderRadius.circular(25),
              ),
               child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  mainAxisAlignment: alignment == TextAlign.left
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.end,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: theme.textTheme.bodyLarge!.color,
                        fontSize: 28, // Adjusted font size
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                      textAlign: alignment,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
