import 'package:flutter/material.dart';
import 'package:uct_app/components/textfield1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dashboard2.dart';

String capitalize(String str) {
  if (str.isEmpty) {
    return str;
  }
  return str[0].toUpperCase() + str.substring(1).toLowerCase();
}
class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String?> signInWithGoogle() async {
    // Sign out first to ensure the account selection dialog is shown
    await googleSignIn.signOut();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
          await firebaseAuth.signInWithCredential(credential);
      final User? user = authResult.user;

      if (user != null) {
        assert(!user.isAnonymous);
        assert(await user.getIdToken() != null);

        final User? currentUser = firebaseAuth.currentUser;
        assert(user.uid == currentUser!.uid);

        // Check if the email domain is alu.uct.cl
        if (user.email!.endsWith('@alu.uct.cl')) {
          print('signInWithGoogle succeeded: $user');

          // Split the username on space and keep the first two parts
          List<String> nameParts = user.displayName!.split(' ');
          String shortName = user
              .displayName!; // default to full name if name has less than two parts
          if (nameParts.length > 1) {
            shortName = capitalize(nameParts[0]) +
                ' ' +
                capitalize(nameParts[1]); // capitalize first and last name
            print('shortName: $shortName');
          }

          return shortName;
        } else {
          print('signInWithGoogle failed: Email domain is not alu.uct.cl');
          return null;
        }
      }
    }

    return null;
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();

    print("User Signed Out");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // this avoids the overflow error

      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // logo
              const Image(
                image: AssetImage('lib/images/Logo_UCT.png'),
                height: 100,
                width: 100,
              ),

              const SizedBox(height: 20),

              Text(
                'Bienvenido!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 10),

              MyTextField(
                controller: usernameController,
                hintText: 'Correo Institucional',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              MyTextField(
                controller: passwordController,
                hintText: 'Contraseña',
                obscureText: true,
              ),

              const SizedBox(height: 10),

              Text(
                'Olvidaste tu Contraseña?',
                style: TextStyle(color: Colors.grey[600]),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  signInWithGoogle().then((String? shortName) {
                    if (shortName != null) {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 500),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  Dash(
                            
                            username: shortName,
                          ),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(0.0, 1.0);
                            const end = Offset.zero;
                            const curve = Curves.ease;
                            final tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));
                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ),
<<<<<<< HEAD
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(0.0, 1.0);
                          const end = Offset.zero;
                          const curve = Curves.ease;
                          final tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                      ),
                    );
                  } else {
                    //if the username field is empty display a small red message, with a way to check if the button is pressed more than once in  a second, make the user wait

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Por favor ingrese su correo'),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 1),
                      ),
                    );
                  }
                },
                child: const Text(
                  'Dashboard antigua',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  final username = usernameController.text;
                  if (username.isNotEmpty) {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 500),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            Dash(
                          username: username,
                        ),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(0.0, 1.0);
                          const end = Offset.zero;
                          const curve = Curves.ease;
                          final tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                      ),
                    );
                  } else {
                    //if the username field is empty display a small red message, with a way to check if the button is pressed more than once in  a second, make the user wait

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Por favor ingrese su correo'),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 1),
                      ),
                    );
                  }
=======
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Failed to sign in with Google'),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 1),
                        ),
                      );
                    }
                  });
>>>>>>> Dev-Nico
                },
                child: const Text(
                  'Sign in with Google',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
<<<<<<< HEAD

              Divider(
                thickness: 0.5,
                color: Colors.grey[400],
              ),

              const SizedBox(height: 10),

              Text(
                'O iniciar sesión con',
                style: TextStyle(color: Colors.grey[700]),
              ),

              const SizedBox(height: 10),
=======
>>>>>>> Dev-Nico

              // ... rest of your code
            ],
          ),
        ),
      ),
    );
  }
}
