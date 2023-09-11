import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key, this.username, this.picture});
  final String? username;
  final String? picture;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi perfil',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 50, 176, 235)),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Perfil de $username'),
        ),
        body: Center(
          child: Column(
            children: [
              Image.network(
                '$picture',
                width: 140,
                height: 140,
              ),
              Text('$username'),
            ],
          ),
        ),
      ),
    );
  }

 
}