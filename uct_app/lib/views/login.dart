// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'dashboard2.dart';
import 'package:googleapis/calendar/v3.dart' as gcal;
import 'package:http/http.dart'
    show BaseRequest, StreamedResponse;
import 'package:http/http.dart' as http;

String capitalize(String str) {
  if (str.isEmpty) {
    return str;
  }
  return str[0].toUpperCase() + str.substring(1).toLowerCase();
}

class EventsModel extends ChangeNotifier {
  List<gcal.Event>? _events;

  List<gcal.Event>? get events => _events;

  void setEvents(List<gcal.Event>? events) {
    _events = events;
    notifyListeners();
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class GoogleHttpClient extends http.BaseClient {
  final Map<String, String> _headers;
  final http.Client _client = http.Client();

  GoogleHttpClient(this._headers);

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    return _client.send(request..headers.addAll(_headers));
  }

  @override
  void close() {
    _client.close();
  }
}

class _LoginPageState extends State<LoginPage> {
  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/calendar.events',
    ],
  );
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  List<gcal.Event>? events;

  Future<String?> signInWithGoogle(
      EventsModel eventsModel, Function(List<gcal.Event>?) callback) async {
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
            shortName = '${capitalize(nameParts[0])} ${capitalize(nameParts[1])}'; // capitalize first and last name
            print('shortName: $shortName');
            print('email: ${user.email}');
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
    EventsModel eventsModel = Provider.of<EventsModel>(context, listen: false);
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
                image: AssetImage('lib/images/google.png'),
                height: 100,
                width: 100,
              ),

              const SizedBox(height: 20),

              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: ElevatedButton(
                  onPressed: () {
                    signInWithGoogle(eventsModel, (events) {})
                        .then((String? shortName) {
                      if (shortName != null) {
                        final User? currentUser = firebaseAuth.currentUser;
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 500),
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    Dash(
                              username: shortName,
                              email:
                                  currentUser!.email!, // pass the email to Dash
                            ),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Failed to sign in with Google'),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 1),
                          ),
                        );
                      }
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered)) {
                          return Colors
                              .blue; // The color when the button is hovered
                        }
                        return Colors.white; // The default color of the button
                      },
                    ),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    side: MaterialStateProperty.all<BorderSide>(
                      const BorderSide(color: Colors.grey, width: 1),
                    ),
                  ),
                  child: const Text(
                    'Iniciar Sesion con Google',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
