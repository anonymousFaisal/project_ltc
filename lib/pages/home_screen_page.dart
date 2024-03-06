import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project_ltc/animation/typewriter_text.dart';
import 'package:project_ltc/components/journey_card.dart';
import 'package:project_ltc/levels/index.dart';

class HomeScreenPage extends StatefulWidget {
  @override
  _HomeScreenPageState createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  late PageController _pageController;
  late Timer _timer;

  // List of C++ tips
  List<String> cppTips = [
    "Always free dynamically allocated memory to avoid memory leaks.",
    "Initialize variables before using them.",
    "Use the 'auto' keyword when appropriate in C++11 and later.",
    "Remember that C++ starts array indices at 0, not 1.",
    "Prefer std::vector over plain arrays for dynamic collections.",
    "There are many easter eggs. Try to find them."
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    // Timer to switch tips
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_pageController.page == cppTips.length - 1) {
        _pageController.animateToPage(0,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut);
      } else {
        _pageController.nextPage(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut);
      }
    });
  }

  // Determine greeting based on current time
  String getTimeBasedGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: CustomScrollView(
        slivers: [
          // App Bar Configuration
          SliverAppBar(
            backgroundColor: theme.primaryColor,
            expandedHeight: 200.0,
            pinned: true,
            elevation: 10.0,
            shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.code, color: theme.iconTheme.color),
              onPressed: () {},
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: const EdgeInsets.all(16.0),
              title: Text(
                "Learn to Code",
                style: TextStyle(
                  fontSize: 20,
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
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.notifications, color: theme.iconTheme.color),
                onPressed: () {},
              ),
              const SizedBox(width: 16),
            ],
          ),

          // Body
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  const SizedBox(height: 20),
                  // Display greeting with a typewriter effect
                  TypeWriterText(
                    text: getTimeBasedGreeting(),
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Motivational message
                  TypeWriterText(
                    text: "Ready to learn C++ today?",
                    delay: Duration(
                        milliseconds: 80 * getTimeBasedGreeting().length),
                    style: TextStyle(
                      fontSize: 21,
                      color: Theme.of(context).textTheme.titleMedium!.color,
                    ),
                  ),

                  // Display rotating C++ tips
                  Container(
                    height: 190,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: cppTips.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 20.0,
                            horizontal: 5.0,
                          ),
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: theme.cardColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    theme.colorScheme.primary.withOpacity(0.15),
                                blurRadius: 6,
                                offset: const Offset(3, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.lightbulb_outline,
                                      size: 32, color: theme.iconTheme.color),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      "C++ Tip of the day",
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: theme.colorScheme.onPrimary),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                color: theme.dividerColor.withOpacity(0.7),
                                thickness: 1.5,
                                height: 20,
                                indent: 40,
                                endIndent: 10,
                              ),
                              Flexible(
                                child: Text(
                                  cppTips[index],
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 19,
                                    color: theme.textTheme.titleMedium!.color,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  // Continue learning section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        "Continue Your Journey",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      ),
                      const SizedBox(height: 20),
                      JourneyCard(
                        title: "Daily Quest",
                        completedLevels: 3,
                        totalLevels: 7,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DailyQuizzesPage()),
                          );
                        },
                      ),
                      JourneyCard(
                        title: "Beginner",
                        completedLevels: 5,
                        totalLevels: 10,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BeginnerPage()),
                          );
                        },
                      ),
                      JourneyCard(
                        title: "Intermediate",
                        completedLevels: 4,
                        totalLevels: 10,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => IntermediatePage()),
                          );
                        },
                      ),
                      JourneyCard(
                        title: "Advanced",
                        completedLevels: 9,
                        totalLevels: 10,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdvancedPage()),
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 200),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
