import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:uct_app/views/especialistas.dart';
import 'package:uct_app/views/forum.dart';
import 'views/compromisosAcademicos.dart';
import 'views/login.dart';
import 'views/dashboard.dart';
import 'views/splash.dart';
import 'views/recursos.dart';
import 'views/calendario.dart';
import 'views/docentes.dart';
import 'package:firebase_core/firebase_core.dart';
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
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
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
        '/login': (context) => const LoginPage(),
        '/especialistas': (context) => const SpecialistPage(),
        '/dashboard': (context) => const MyHomePage(
              title: 'Cinap',
              username: '',
              email: '',
            ),
        '/recursos': (context) => RecursosPage(),
        '/docentes': (context) => const DocentesPage(),
        '/compromisosacademicos': (context) => CompromisosAcademicosPage(),
        '/canalesDeApoyo': (context) => const CanalesDeApoyoPage(),
        '/programacionRegular': (context) => const programacionRegularPage(),
        '/instanciasFormacion': (context) => const VistaConImagen(),
        '/orientacionesDocencia': (context) => const DocentesPage(),
        '/virtualizacion': (context) => const DocentesPage(),
        '/eventos': (context) => ChangeNotifierProvider<EventsModel>(
              create: (context) => EventsModel(),
              child: const UpcomingEventsPage(),
            ),
        '/ticlab': (context) => const DocentesPage(),
        '/foro': (context) => QuestionForumPage(),
      },
    );
  }
}
