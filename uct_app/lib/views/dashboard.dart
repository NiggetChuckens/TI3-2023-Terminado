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
    //initialize the date formatter using intl package
    initializeDateFormatting();
  
    //define the locale to be spain
    String locale = 'es';
    //set the date time the dashboard will fetch to be the datetime of actual (now)
    DateTime now = DateTime.now();
    String dayOfWeek = DateFormat.EEEE(locale).format(now);
    String dayMonth = DateFormat.MMMMd(locale).format(now);
    String year = DateFormat.y(locale).format(now);
    //define the year day and month to be set by a locale variable (now)
    String nombre = 'Juan';
    //set an example name for the user logged in currently
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
              title: const Text('Chat de Ayuda'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/profile_grid');
              },
            ),
            ListTile(
              title: const Text('Recursos'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/recursos');
              },
            ),
          ],
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(
            16), // Add spacing between the buttons and the screen
        mainAxisSpacing: 16, // Add spacing between the buttons vertically
        crossAxisSpacing: 16, // Add spacing between the buttons horizontally
        children: [
          Center(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(10), // strength of rounded corners
              ),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/profile_grid');
                },
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('lib/images/Docentes.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Placeholder for the second card
          Center(
            child: Card(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/recursos');
                },
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(10), // strength of round corners
                  clipBehavior: Clip
                      .antiAlias, // Clip the child widget with rounded corners
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('lib/images/Default.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}