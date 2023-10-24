import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uct_app/views/especialistas.dart';
import 'views/compromisosAcademicos.dart';
import 'views/login.dart';
import 'views/dashboard.dart';
import 'views/splash.dart';
import 'views/recursos.dart';
import 'views/calendario.dart';
import 'views/docentes.dart';
import 'package:firebase_core/firebase_core.dart';

import 'views/upcoming.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider<EventsModel>(
      create: (context) => EventsModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        '/login': (context) => LoginPage(),
        '/especialistas': (context) => SpecialistPage(),
        '/dashboard': (context) => const MyHomePage(
              title: 'DTE',
              username: '',
            ),
        '/calendario': (context) => const CalendarPage(),
        '/recursos': (context) => const RecursosPage(),
        '/docentes': (context) => const DocentesPage(),
        '/compromisosacademicos': (context) => CompromisosAcademicosPage(),
        '/canalesDeApoyo': (context) => DocentesPage(),
        '/programacionRegular': (context) => DocentesPage(),
        '/instanciasFormacion': (context) => DocentesPage(),
        '/orientacionesDocencia': (context) => DocentesPage(),
        '/virtualizacion': (context) => DocentesPage(),
        '/eventos': (context) => ChangeNotifierProvider<EventsModel>(
              create: (context) => EventsModel(),
              child: UpcomingEventsPage(),
            ),
      },
    );
  }
}
