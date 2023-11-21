import 'package:flutter/material.dart';

class TalleresTiclab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue, // Fondo azul claro
      appBar: AppBar(
        backgroundColor: Colors.lightBlue, // Fondo azul claro
        title: Text('Talleres Ticlab', style: TextStyle(color: Colors.white)), // Título en blanco
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'TICLAB es una instancia de formación para los docentes de la UC Temuco, realizada desde el año 2018. Actualmente existen dos modalidades; \nTICLAB CERETI – DTE conformado por 4 talleres de formación práctica para la utilización de recursos tecnológicos, orientados \nal conocimiento y utilización de aplicaciones y herramientas que faciliten la inclusión. Y los talleres clasicos de TICLAB, los cuales para este primer semestre 2022 \nestan orientados al desarrollo de capacidades en las áreas de diseño, diagramación y multimedia.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white), // Letras en blanco
            ),
            SizedBox(height: 16.0), // Espacio entre el título y los cuadros de texto
            Container(
              color: Colors.lightBlue, // Fondo azul claro
              child: Column(
                children: <Widget>[
                  Text('TICLAB\nModalidad: Online\n Inscripción: semanal\nCupos: 30\nFecha Inicio: 26 de abril\nFecha Término: 24 de junio\n', style: TextStyle(color: Colors.white)), // Letras en blanco
                  ElevatedButton(
                    child: Text('>>Más información'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // Fondo azul oscuro
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Borde redondeado
                      ),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0), // Espacio entre los cuadros de texto
            Container(
              color: Colors.lightBlue, // Fondo azul claro
              child: Column(
                children: <Widget>[
                  Text('TICLAB CERETI – DTE\nModalidad: Mixta (1 clase Online y 2 sesiones presenciales)\nInscripción: 17 al 20 de marzo\nCupos: 30\nFecha Inicio: 23 de marzo\nFecha Término: 1 al 15 de abril', style: TextStyle(color: Colors.white)), // Letras en blanco
                  ElevatedButton(
                    child: Text('>>Más información'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // Fondo azul oscuro
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Borde redondeado
                      ),
                    ),
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
