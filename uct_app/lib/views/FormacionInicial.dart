import 'package:flutter/material.dart';

class Formacioninicialdocente extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue, // Fondo azul claro
      appBar: AppBar(
        backgroundColor: Colors.lightBlue, // Fondo azul claro
        title: const Text('', style: TextStyle(color: Colors.white)), // Título en blanco
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              '',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white), // Letras en blanco
            ),
            const SizedBox(height: 16.0), // Espacio entre el título y los cuadros de texto
            Container(
              color: Colors.lightBlue, // Fondo azul claro
              child: Column(
                children: <Widget>[
                  const Text('Inducción al uso de EDUCA Blackboard\nModalidad: Autoinstruccional\nInscripción: 15 al 18 de marzo\nCupos: ilimitados\nFecha Inicio: 21 marzo\nFecha Término: 08 abril\n', style: TextStyle(color: Colors.white)), // Letras en blanco
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // Fondo azul oscuro
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Borde redondeado
                      ),
                    ),
                    child: const Text('>>mas informcacion'),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
                        const SizedBox(height: 16.0), // Espacio entre el título y los cuadros de texto
            Container(
              color: Colors.lightBlue, // Fondo azul claro
              child: Column(
                children: <Widget>[
                  const Text('Inducción al uso de salas híbridas,\n aplicado al modelo pedagógico Hyflex\nModalidad: Mixta (online/presencial)\nInscripción: 16 al 21 de marzo\nCupos: 30\nFecha Inicio: 22 de marzo\nFecha Término: 1 al 15 de abril\n', style: TextStyle(color: Colors.white)), // Letras en blanco
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // Fondo azul oscuro
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Borde redondeado
                      ),
                    ),
                    child: const Text('>>mas informcacion'),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
                       Container(
              color: Colors.lightBlue, // Fondo azul claro
              child: Column(
                children: <Widget>[
                  const Text('Virtualización de módulos de aprendizaje\nModalidad: Online\nInscripción: 16 al 21 de marzo\nCupos: 30\nFecha Inicio: 23 de marzo\nFecha Término: 15 al 30 de abril', style: TextStyle(color: Colors.white)), // Letras en blanco
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // Fondo azul oscuro
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Borde redondeado
                      ),
                    ),
                    child: const Text('>>mas informcacion'),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0), // Espacio entre los cuadros de texto
            Container(
              color: Colors.lightBlue, // Fondo azul claro
              child: Column(
                children: <Widget>[
                  const Text('Docencia en línea\nModalidad: Online (1 masterclass semanal, los días miércoles en horario de 11 a 12 horas. Total 4 masterclass)\nInscripción: 28 de marzo al 04 de abril\nCupos: 30\nFecha Inicio: 06 de abril\nFecha Término: 1 al 15 de mayo', style: TextStyle(color: Colors.white)), // Letras en blanco
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // Fondo azul oscuro
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Borde redondeado
                      ),
                    ),
                    child: const Text('>>mas informcacion'),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
