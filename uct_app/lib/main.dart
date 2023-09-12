import 'package:flutter/material.dart';
import 'views/login.dart';
import 'views/profile_grid.dart';
import 'views/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/profile_grid': (context) => const ProfilesGrid(),
        '/dashboard': (context) => const MyHomePage(
              title: 'DTE',
            ),
      },
    );
  }
}
