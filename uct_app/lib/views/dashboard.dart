import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    String locale = 'es';
    DateTime now = DateTime.now();
    String dayOfWeek = DateFormat.EEEE(locale).format(now);
    String dayMonth = DateFormat.MMMMd(locale).format(now);
    String year = DateFormat.y(locale).format(now);
    String nombre = 'Juan';

    return Scaffold(
      appBar: AppBar(
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
        title: Row(
          children: [
            Text(widget.title),
            const SizedBox(width: 10),
            const Spacer(),
            Image.asset(
              'lib/images/Logo_UCT.png',
              height: 40,
            ),
          ],
        ),
      ),
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
                      'Bienvenido, $nombre',
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
                Navigator.pushNamed(context, '/profile_grid');
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
          ],
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: [
          _buildCard('/profile_grid', 'lib/images/asesor.png'),
          _buildCard('/docentes', 'lib/images/docentes.png'),
          _buildCard('/calendario', 'lib/images/calendar_icon.png'),
          _buildCard('/about', 'lib/images/uct_splash.png'),
          _buildCard('/recursos', 'lib/images/recursos.png'),
          _buildCard('/contacto', 'lib/images/contacto.png'),
          _buildCard('/foro', 'lib/images/Default.jpg'),
          _buildCard('/chat', 'lib/images/Default.jpg'),
        ],
      ),
    );
  }

  Widget _buildCard(String route, String imagePath) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, route);
          },
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
