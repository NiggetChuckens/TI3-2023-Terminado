import 'package:flutter/material.dart';
import 'package:uct_app/views/profile.dart';

class ProfilesGrid extends StatelessWidget {
  const ProfilesGrid({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayudantias disponibles'),
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.yellow],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
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
                        picture: 'https://dte.uct.cl/wp-content/uploads/2018/06/monica_keachele.jpg',
                        description:
                            'this is a test description, assume this guy is good at building rockets or something lol',
                        email: 'mrkim@northkorea.net',
                        service: 'Especializado en operaciones terroristas, relaciones sociales y amabilidad, disponible los 7 dias de la semana',
                        experience: 'Amplio trabajo con armamento militar, bombas y abrazos, capaz de ayudar a solucionar los problemas que puedas tener',
                        schedule: 'Lunes a Domingo - 8:00 a 17:00',
                        comment: 'Nice job',
                      ),
                    ),
                  );
                },
                child: Column( children: [
                  Image.network('https://dte.uct.cl/wp-content/uploads/2018/06/monica_keachele.jpg',
                  width: 140,
                  height: 140,
                  ),
                  const Text('Kim Yong Un'),
                ],
              ),
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
                      description:
                            'this is a test description, assume this guy is good at programing or something else',
                        email: 'lilputin@invadeuk.meme',
                        service: 'a',
                        experience: 'a',
                        schedule: 'a',
                        comment: 'Nice job',
                    ),
                  ),
                );
              },
              child: Column(children: [
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
                      description:
                            'this is a test description, assume this guy is good at sniffing stuff or idk',
                        email: 'donald@cuack.lake',
                        service: 'a',
                        experience: 'a',
                        schedule: 'a',
                        comment: 'Nice job',
                    ),
                  ),
                );
              },
              child: Column(children: [
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
