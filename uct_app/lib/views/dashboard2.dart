import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:uct_app/components/category_cards.dart';
import 'package:uct_app/views/dashboard.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
<<<<<<< HEAD
import 'package:uct_app/components/data.dart';

=======
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
>>>>>>> Dev-Nico
class Dash extends StatefulWidget {
  const Dash({Key? key, required this.username}) : super(key: key);
  final String username;

  @override
  State<Dash> createState() => _DashState();
}

class _DashState extends State<Dash> {
  @override
  Widget build(BuildContext context) {
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
              title: const Text('Calendario'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/calendario');
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
           
            ListTile(
              title: const Text('Dashboard1'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(
                      title: 'DTE',
                      username: widget.username,
                    ),
                  ),
                );
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
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Bienvenido,',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      widget.username,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                Builder(
                  builder: (context) => Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyHomePage(
                                title: 'DTE',
                                username: widget.username,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.deepPurple[100],
                          ),
                          child: const Icon(Icons.person),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),

          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.pink[100],
                    borderRadius: BorderRadius.circular(12)),
                child: Row(children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Lottie.network(
                        'https://assets10.lottiefiles.com/packages/lf20_tutvdkg0.json'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Como te sientes hoy?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const Text(
                          'Agenda tu cita si lo necesitas',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/calendario');
                          },
                          child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.deepPurple[300],
                              ),
                              child: const Center(
                                child: Text(
                                  'Empezemos',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                        )
                      ],
                    ),
                  )
                ]),
              )),
          const SizedBox(height: 25),

          //SEARCH BAR
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.deepPurple[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Que estas buscando?',
                  ),
                ),
              )),

          const SizedBox(height: 25),

<<<<<<< HEAD
//LIST VIEW
=======
      //LIST VIEW
>>>>>>> Dev-Nico
          SizedBox(
            height: 80,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildButton(
<<<<<<< HEAD
                    'Asesores', '/profile_grid', 'lib/images/asesor.png'),
=======
                    'Asesores', '/especialistas', 'lib/images/asesor.png'),
>>>>>>> Dev-Nico
                _buildButton(
                    'Docentes', '/docentes', 'lib/images/Docentes.png'),
                _buildButton('Calendario', '/calendario',
                    'lib/images/calendar_icon.png'),
                _buildButton('About', '/about', 'lib/images/uct_splash.png'),
                _buildButton(
                    'Recursos', '/recursos', 'lib/images/recursos.png'),
                _buildButton(
                    'Contacto', '/contacto', 'lib/images/contacto.png'),
<<<<<<< HEAD
                _buildButton('Foro', '/foro', 'lib/images/Default.jpg'),
                _buildButton(
                    'Chat de Apoyo', '/chat', 'lib/images/Default.jpg'),
                _buildButton('Dashboard2', '/dash2', 'lib/images/Default.jpg'),
              ],
            ),
          ),

=======
                _buildButton('Foro', '/foro', 'lib/images/foro.png'),
                _buildButton(
                    'Chat de Apoyo', '/chat', 'lib/images/chat.png'),
                
              ],
            ),
          ),
          const SizedBox(height: 25),
          
>>>>>>> Dev-Nico
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'En Progreso',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'Ver todos',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.grey[500]),
                ),
              ],
            ),
          ),
<<<<<<< HEAD
          const SizedBox(height: 25),

          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: specialists.length,
              itemBuilder: (BuildContext context, int index) {
                return Especialista(
                  doctorImagePath: specialists[index].image,
                  rating: specialists[index].rating.toString(),
                  doctorName: specialists[index].name,
                  doctorSpecialty: specialists[index].category,
                );
              },
            ),
          ),
=======
          
>>>>>>> Dev-Nico
          const SizedBox(
            height: 100,
          )
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
<<<<<<< HEAD
}
=======
}
>>>>>>> Dev-Nico
