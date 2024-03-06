import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_ltc/components/my_textfield.dart';
import 'package:project_ltc/components/my_button.dart';
import 'package:project_ltc/components/square_tile.dart';
import 'package:project_ltc/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  LoginPage({
    super.key,
    required this.onTap,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn() async {
    //show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    // try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // remove the loading circle
      Navigator.pop(context);
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
              style:  const TextStyle(color: Colors.white,)
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
                const SizedBox(height: 50),

                // logo
                Icon(
                  Icons.code_rounded,
                  size: 100,
                  color: theme.iconTheme.color,
                ),

                const SizedBox(height: 50),

                //welcome back, you've been missed
                Text(
                  'Welcome back you\'ve been missed',
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
                //forgot password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password',
                        style: TextStyle(color: theme.textTheme.titleSmall!.color),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),
                //sign in button
                MyButton(
                  onTap: signUserIn,
                  text: 'Sign In',
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
                        'One Tap Sign In',
                        style: TextStyle(color: theme.textTheme.bodyLarge!.color),
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

                const SizedBox(height: 40),

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
                      'Not a member?',
                      style: TextStyle(color: theme.textTheme.titleSmall!.color),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Register Now',
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
