import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_ltc/components/my_textfield.dart';
import 'package:project_ltc/components/my_button.dart';
import 'package:project_ltc/components/square_tile.dart';
import 'package:project_ltc/services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // sign user up method
  void signUserUp() async {
    //show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    // try creating the user
    try {
      // check if password is confirmed
      if (passwordController.text == confirmPasswordController.text) {
        //create the user
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        // after creating , create a new doucment in the firestore 'Users'
        FirebaseFirestore.instance
            .collection("Users")
            .doc(userCredential.user!.email)
            .set({
          'username': emailController.text.split('@')[0], //initial username
          //additional fields
          'mobile': "",
          'country': "",
          'profession': "",
          "institute": "",
          "about me": "",
        });

        // remove the loading circle
        Navigator.pop(context);
      } else {
        // remove the loading circle
        Navigator.pop(context);
        // show error message, password fon't match
        showErrorMessage("Passwords don't match");
      }
    } on FirebaseAuthException catch (e) {
      // remove the loading circle
      Navigator.pop(context);

      // show error message
      showErrorMessage(e.code);
    }
  }

  // error message to user
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 25),

                // logo
                Icon(
                  Icons.code_rounded,
                  size: 50,
                  color: theme.iconTheme.color,
                ),

                const SizedBox(height: 25),

                // let's create an account for you
                Text(
                  'Let\'s create an account for you!',
                  style: TextStyle(
                    color: theme.textTheme.bodyLarge!.color,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),
                //Email textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'E-mail',
                  obsecureText: false,
                ),

                const SizedBox(height: 10),
                //password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obsecureText: true,
                ),

                const SizedBox(height: 10),

                // confirm password textfield
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obsecureText: true,
                ),

                const SizedBox(height: 25),

                //sign in button
                MyButton(
                  onTap: signUserUp,
                  text: 'Sign Up',
                ),

                const SizedBox(height: 50),

                //or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: theme.dividerColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or Continue With',
                        style: TextStyle(color: theme.textTheme.labelMedium!.color),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: theme.dividerColor,
                      ),
                    ),
                  ]),
                ),

                const SizedBox(height: 50),

                //google + apple sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    SquareTile(
                      imagePath: 'lib/images/google.png',
                      onTap: () => AuthService().signInWithGoogle(),
                    ),
                  ],
                ),

                const SizedBox(height: 50),

                //not a member? Register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: theme.textTheme.titleSmall!.color),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Login Now',
                        style: TextStyle(
                          color: theme.colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
