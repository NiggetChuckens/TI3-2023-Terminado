import 'package:flutter/material.dart';
import 'package:uct_app/views/assistant.dart';
import 'package:uct_app/views/profile.dart';

class ProfilesGrid extends StatelessWidget {
  const ProfilesGrid({super.key});
  @override
  Widget build(BuildContext context){
  return Scaffold(
      appBar: AppBar(
        title: const Text('Ayudantias disponibles'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Profile(
                      username: 'Kim Yong Un',
                      picture: 'https://i.imgur.com/BoN9kdC.jpeg',
                    ),
                  ),
                );
              },
              child: const Assistant(
                username: 'Kim Yong Unn',
                picture: 'https://i.imgur.com/BoN9kdC.jpeg',)
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Profile(
                      username: 'Vladimir Putin',
                      picture: 'https://i.imgur.com/BoN9kdC.jpeg',
                    ),
                  ),
                );
              },
              child: Column(
                children: [
                  Image.network(
                    'https://i.imgur.com/BoN9kdC.jpeg',
                    width: 140,
                    height: 140,
                  ),
                  const Text('Vladimir Putin'),
              ]),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Profile(
                      username: 'Donald Trump',
                      picture: 'https://i.imgur.com/BoN9kdC.jpeg',
                    ),
                  ),
                );
              },
              child: Column(
                children: [
                  Image.network(
                    'https://i.imgur.com/BoN9kdC.jpeg',
                    width: 140,
                    height: 140,
                  ),
                  const Text('Donald Trump'),
              ]),
            ),
          ),
          
        ],
      ),
    );
  }
}