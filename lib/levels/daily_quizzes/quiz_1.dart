import 'package:flutter/material.dart';

class Quiz1Page extends StatefulWidget {
  @override
  State<Quiz1Page> createState() => _Quiz1PageState();
}

class _Quiz1PageState extends State<Quiz1Page> {
  // list of lines for "Hello, World!" C++ program
  final List<String> myTiles = [
    '  return 0;',
    '}',
    '#include<iostream>',
    'int main() {',
    '  cout << "Hello, World!" << endl;',
    'using namespace std;',
  ];

  // correct order for the lines
  final List<String> correctOrder = [
    '#include<iostream>',
    'using namespace std;',
    'int main() {',
    '  cout << "Hello, World!" << endl;',
    '  return 0;',
    '}',
  ];

  // reorder method
  void updateMyTiles(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }

      // get the tile that are moving
      final String tile = myTiles.removeAt(oldIndex);
      // placing the tile in new position
      myTiles.insert(newIndex, tile);
    });

    if (myTiles.join() == correctOrder.join()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Level Complete!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Unscramble the Code!',
          style: TextStyle(
            color: theme.textTheme.bodyLarge!.color,
            fontSize: 22,
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            // Contextual information
            Text(
              "Hey there, Code Wizard!",
              style: theme.textTheme.bodyMedium!.copyWith(fontSize: 24),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 10),
            Text(
              "A 'Hello, World!' in C++ got scrambled. Can you set things right?",
              style: TextStyle(
                color: theme.textTheme.bodyLarge!.color,
                fontSize: 18,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 20),
            Divider(color: theme.dividerColor),
            SizedBox(height: 20),
            Expanded(
              child: ReorderableListView(
                padding: const EdgeInsets.symmetric(vertical: 10),
                children: [
                  for (final tile in myTiles)
                    Padding(
                      key: ValueKey(tile),
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Material(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(10),
                        elevation: 0,
                        child: ListTile(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                          title: Text(tile, style: theme.textTheme.bodyMedium),
                          trailing: Icon(Icons.drag_handle,
                              color: theme.iconTheme.color),
                        ),
                      ),
                    ),
                ],
                onReorder: (oldIndex, newIndex) {
                  updateMyTiles(oldIndex, newIndex);
                },
              ),
            ),
          ],
        ),
      ),
      backgroundColor: theme.colorScheme.background,
    );
  }
}
