import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
<<<<<<< HEAD
import 'package:uct_app/components/specialist_cards.dart';
import 'package:uct_app/components/category_cards.dart';
import 'package:uct_app/components/sort_category.dart';
import 'package:uct_app/views/dashboard.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:uct_app/components/data.dart';

class Dash extends StatefulWidget {
  const Dash({Key? key, required this.username}) : super(key: key);
=======
import 'package:uct_app/components/category_cards.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:uct_app/components/upcomingcalendar.dart';

class Dash extends StatefulWidget {
  const Dash({Key? key, required this.username, required String email})
      : super(key: key);
>>>>>>> Dev-Rob
  final String username;

  @override
  State<Dash> createState() => _DashState();
}

class _DashState extends State<Dash> {
<<<<<<< HEAD
  @override
  Widget build(BuildContext context) {
=======
  Key key = UniqueKey();

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

>>>>>>> Dev-Rob
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
<<<<<<< HEAD
                Navigator.pushNamed(context, '/profile_grid');
=======
                Navigator.pushNamed(context, '/especialistas');
>>>>>>> Dev-Rob
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
<<<<<<< HEAD
              title: const Text('Calendario'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/calendario');
              },
            ),
            ListTile(
=======
>>>>>>> Dev-Rob
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
<<<<<<< HEAD
            ListTile(
              title: const Text('Dashboard2'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Dash(
                      username: widget.username,
                    ),
                  ),
                );
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
=======
>>>>>>> Dev-Rob
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
<<<<<<< HEAD
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
=======
                          Navigator.pushNamed(context, '/docentes');
                        },
                        child: Container(
                          //profile box top right corner
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color.fromARGB(225, 225, 225, 225),
>>>>>>> Dev-Rob
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
<<<<<<< HEAD
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.pink[100],
=======
                //welcome message box c:
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    gradient: gradient,
                    //color: Color.fromARGB(255, 169, 201, 237),
>>>>>>> Dev-Rob
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
<<<<<<< HEAD
                          'Agenda tu cita si lo necesitas',
=======
                          'Agenda tu cita',
>>>>>>> Dev-Rob
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
<<<<<<< HEAD
                            Navigator.pushNamed(context, '/calendario');
=======
                            Navigator.pushNamed(context, '/especialistas');
>>>>>>> Dev-Rob
                          },
                          child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
<<<<<<< HEAD
                                color: Colors.deepPurple[300],
=======
                                //gradient: gradientSearch,
                                color: const Color(0xFF8FB5E1),
>>>>>>> Dev-Rob
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
<<<<<<< HEAD
                  color: Colors.deepPurple[100],
=======
                  gradient: gradientSearch,
                  color: const Color.fromARGB(255, 232, 196, 233),
>>>>>>> Dev-Rob
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
>>>>>>> Dev-Rob
          SizedBox(
            height: 80,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildButton(
<<<<<<< HEAD
                    'Asesores', '/profile_grid', 'lib/images/asesor.png'),
                _buildButton(
                    'Docentes', '/docentes', 'lib/images/Docentes.png'),
                _buildButton('Calendario', '/calendario',
                    'lib/images/calendar_icon.png'),
=======
                    'Asesores', '/especialistas', 'lib/images/asesor.png'),
                _buildButton(
                    'Docentes', '/docentes', 'lib/images/Docentes.png'),
                _buildButton(
                    'Eventos Proximos', '/eventos', 'lib/images/chat.png'),
>>>>>>> Dev-Rob
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

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Especialistas',
=======
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
>>>>>>> Dev-Rob
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
<<<<<<< HEAD
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
          const SizedBox(
            height: 100,
          )
=======
              ],
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          // Add the upcoming events component
          Expanded(
            key: key,
            child: UpcomingEventsComponent(),
          ),
>>>>>>> Dev-Rob
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
