import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'views/login.dart';
import 'views/profile_grid.dart';
=======
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:uct_app/views/especialistas.dart';
import 'views/compromisosAcademicos.dart';
import 'views/login.dart';
>>>>>>> Dev-Rob
import 'views/dashboard.dart';
import 'views/splash.dart';
import 'views/recursos.dart';
import 'views/calendario.dart';
import 'views/docentes.dart';
<<<<<<< HEAD

import 'views/compromisosAcademicos.dart';
import 'views/canalesDeApoyo.dart';
import 'views/talleresTiclab.dart';
import 'views/CursoEduca.dart';
import 'views/FormacionInicial.dart';
import 'views/canalesDeApoyo.dart';
import 'views/programacionRegular.dart';
import 'views/instanciasFormacion.dart';
import 'views/orientacionesDocencia.dart';
import 'views/virtualizacion.dart';
import 'views/dashboard2.dart';

void main() {
  runApp(const MyApp());
=======
import 'package:firebase_core/firebase_core.dart';
import 'views/ticlab.dart';
import 'views/upcoming.dart';

import 'views/canalesDeApoyo.dart';
import 'views/programacionRegular.dart';
import 'views/instanciasFormacion.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeDateFormatting('es', null); // Add this line

  runApp(
    ChangeNotifierProvider<EventsModel>(
      create: (context) => EventsModel(),
      child: const MyApp(),
    ),
  );
>>>>>>> Dev-Rob
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
<<<<<<< HEAD
      routes: {
        '/login': (context) => LoginPage(),
        '/profile_grid': (context) => const ProfilesGrid(),
        '/dashboard': (context) => const MyHomePage(
              title: 'DTE',
              username: '',
            ),
        '/calendario': (context) => const CalendarPage(),
        '/recursos': (context) => const RecursosPage(),
        '/docentes': (context) => const DocentesPage(),
        '/compromisosacademicos': (context) => CompromisosAcademicosPage(),
        '/canalesDeApoyo': (context) => CanalesDeApoyoPage(),
        '/talleresticlab': (context) => TalleresTiclab(),
        '/cursoeduca': (context) => CursoEduca(),
        '/canalesdeapoyo': (context) => CanalesDeApoyoPage(),
        '/formacioninicialdocente': (context) => Formacioninicialdocente(),
        '/programacionRegular': (context) => programacionRegularPage(),
        '/instanciasFormacion': (context) => VistaConImagen(),
        '/orientacionesDocencia': (context) => DocentesPage(),
        '/virtualizacion': (context) => DocentesPage(),
        '/dash2': (context) => const Dash(
              username: '',
            ),
=======
      onGenerateRoute: (settings) {
        if (settings.name == '/calendario') {
          final Map<String, String> args =
              settings.arguments as Map<String, String>;
          final String specialistEmail = args['email'] ?? '';
          final String specialistName = args['name'] ?? '';
          return MaterialPageRoute(builder: (context) {
            return CalendarPage(
                specialistEmail: specialistEmail,
                specialistName: specialistName);
          });
        }
        // Define your other routes here...
        return null;
      },
      routes: {
        '/login': (context) => LoginPage(),
        '/especialistas': (context) => const SpecialistPage(),
        '/dashboard': (context) => const MyHomePage(
              title: 'DTE',
              username: '',
              email: '',
            ),
        '/recursos': (context) => RecursosPage(),
        '/docentes': (context) => const DocentesPage(),
        '/compromisosacademicos': (context) => CompromisosAcademicosPage(),
        '/canalesDeApoyo': (context) => CanalesDeApoyoPage(),
        '/programacionRegular': (context) => programacionRegularPage(),
        '/instanciasFormacion': (context) => VistaConImagen(),
        '/orientacionesDocencia': (context) => const DocentesPage(),
        '/virtualizacion': (context) => const DocentesPage(),
        '/eventos': (context) => ChangeNotifierProvider<EventsModel>(
              create: (context) => EventsModel(),
              child: UpcomingEventsPage(),
            ),
        '/ticlab': (context) => const DocentesPage(),
>>>>>>> Dev-Rob
      },
    );
  }
}
