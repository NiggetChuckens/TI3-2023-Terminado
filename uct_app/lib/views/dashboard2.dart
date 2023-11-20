import 'package:flutter/material.dart';
import 'package:uct_app/components/category_cards.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:uct_app/components/empezemos.dart';
import 'package:uct_app/components/upcomingcalendar.dart';
import 'package:uct_app/components/topbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uct_app/components/busqueda.dart';

class Dash extends StatefulWidget {
  const Dash({Key? key, required this.username, required String email})
      : super(key: key);
  final String username;

  @override
  State<Dash> createState() => _DashState();
}

class _DashState extends State<Dash> {
  Key key = UniqueKey();
  String photoUrl = FirebaseAuth.instance.currentUser!.photoURL ?? '';

  @override
  Widget build(BuildContext context) {
    const gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFF8FB5E1),
        Color(0xFFD190E0),
      ],
    );

    const gradientSearch = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFFD190E0),
        Color(0xFF8FB5E1),
      ],
    );

    initializeDateFormatting();
    String locale = 'es';
    DateTime now = DateTime.now();
    String dayOfWeek = DateFormat.EEEE(locale).format(now);
    String dayMonth = DateFormat.MMMMd(locale).format(now);
    String year = DateFormat.y(locale).format(now);
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 150,
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bienvenido, ${widget.username}!',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'La fecha de hoy es $dayOfWeek, $dayMonth $year',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              title: const Text('Asesores'),
              onTap: () {
                Navigator.pop(context); // close the drawer
                Navigator.pushNamed(context, '/especialistas');
              },
            ),
            ListTile(
              title: const Text('Docentes'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/docentes');
              },
            ),
            ListTile(
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/about');
              },
            ),
            ListTile(
              title: const Text('Recursos'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/recursos');
              },
            ),
            ListTile(
              title: const Text('Contacto'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/contacto');
              },
            ),
            ListTile(
              title: const Text('Foro'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/foro');
              },
            ),
            ListTile(
              title: const Text('Chat de Apoyo'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/chat');
              },
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TopBar(
                username: widget.username,
                photoUrl: photoUrl,
                email: FirebaseAuth.instance.currentUser!.email!),
          ),
          const SizedBox(height: 25),
          const WelcomeMessageBox(gradient: gradient),
          const SizedBox(height: 25),
          const Busqueda(gradientSearch: gradientSearch),
          const SizedBox(height: 25),
          SizedBox(
            height: 80,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildButton(
                    'Asesores', '/especialistas', 'lib/images/asesor.png'),
                _buildButton(
                    'Docentes', '/docentes', 'lib/images/Docentes.png'),
                _buildButton(
                    'Eventos Proximos', '/eventos', 'lib/images/chat.png'),
                _buildButton('About', '/about', 'lib/images/uct_splash.png'),
                _buildButton(
                    'Recursos', '/recursos', 'lib/images/recursos.png'),
                _buildButton(
                    'Contacto', '/contacto', 'lib/images/contacto.png'),
                _buildButton('Ticlab', '/ticlab', 'lib/images/ticlab.png'),
                _buildButton('Chat', '/chat', 'lib/images/chat.png'),
              ],
            ),
          ),
          const SizedBox(height: 25),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Eventos Proximos',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            key: key,
            child: const UpcomingEventsComponent(),
          ),
        ],
      )),
    );
  }

  Widget _buildButton(String name, String route, String imagePath) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Category(
        categoryName: name,
        iconImagePath: imagePath,
      ),
    );
  }
}
