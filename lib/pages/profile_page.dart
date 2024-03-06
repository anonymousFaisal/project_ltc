import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_ltc/components/text_box.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final userCollection = FirebaseFirestore.instance.collection("Users");

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(color: theme.textTheme.bodyMedium!.color),
        ),
        backgroundColor: theme.primaryColor,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .doc(currentUser.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;

            return ListView(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: theme.primaryColor,
                    child: Icon(Icons.person,
                        size: 60, color: theme.colorScheme.secondary),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
                Text(
                  currentUser.email!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: theme.textTheme.bodyLarge!.color,
                    fontSize: 20,
                  ),
                ),

                const SizedBox(
                  height: 50,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text(
                    'My details',
                    style: TextStyle(color: theme.textTheme.bodyLarge!.color),
                  ),
                ),

                MyTextBox(
                  text: userData['username'],
                  sectionName: 'User Name',
                  onPressed: () => editField('username'),
                ),

                MyTextBox(
                  text: userData['mobile'],
                  sectionName: 'Mobile No',
                  onPressed: () => editField('mobile'),
                ),

                MyTextBox(
                  text: userData['country'],
                  sectionName: 'Country',
                  onPressed: () => editField('country'),
                ),

                MyTextBox(
                  text: userData['profession'],
                  sectionName: 'Profession',
                  onPressed: () => editField('profession'),
                ),

                MyTextBox(
                  text: userData['institute'],
                  sectionName: 'Institute',
                  onPressed: () => editField('institute'),
                ),

                MyTextBox(
                  text: userData['about me'],
                  sectionName: 'About Me',
                  onPressed: () => editField('about me'),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error${snapshot.error}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Edit $field",
          style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
        ),
        content: TextField(
          autofocus: true,
          style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
          decoration: InputDecoration(
            hintText: "Enter new $field",
            hintStyle:
                TextStyle(color: Theme.of(context).textTheme.titleSmall!.color),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          TextButton(
            child: Text(
              'Cancel',
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text(
              'Save',
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
            onPressed: () => Navigator.of(context).pop(newValue),
          ),
        ],
      ),
    );

    if (newValue.trim().isNotEmpty) {
      await userCollection.doc(currentUser.email).update({field: newValue});
    }
  }
}
