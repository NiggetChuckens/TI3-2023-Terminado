import 'package:flutter/material.dart';
import 'views/login.dart';
import 'views/profile_grid.dart';
import 'views/dashboard.dart';
import 'views/splash.dart';
import 'views/recursos.dart';
import 'views/calendario.dart';
import 'views/docentes.dart';

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
      },
    );
  }
}
