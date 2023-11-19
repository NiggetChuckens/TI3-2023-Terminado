import 'package:flutter/material.dart';

class CanalesDeApoyoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Canales de Apoyo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Canales de apoyo',
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan),
            ),
            Text(
              'En esta sección encontrarás los diferentes tipos de ayuda que tenemos para ti, sobre la configuración y uso tecnológico y pedagógico, de las plataformas LMS de la UCTemuco.',
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
            SizedBox(height: 16.0), // Espacio entre el subtítulo y los botones
            ListTile(
              leading: Icon(Icons.info_outline, color: Colors.blue),
              title:
                  Text('Apoyo en linea', style: TextStyle(color: Colors.blue)),
              subtitle: Text('por el momento no esta disponible'),
              trailing: ElevatedButton(
                child: Text('Revisar'),
                onPressed: () {
                  // Navegación a la vista del Botón 1
                  //Navigator.push(
                  //context,
                  //MaterialPageRoute(builder: (context) => Boton1Page()),
                  //);
                },
              ),
            ),
            // Repite para los otros tres botones
            ListTile(
              leading: Icon(Icons.info_outline, color: Colors.blue),
              title: Text('material de apoyo docente',
                  style: TextStyle(color: Colors.blue)),
              subtitle: Text(
                  'a continuacion encontrara material con video y/o infografias para ayudarte a ti como docente a utilizar las plataformas LMS'),
              trailing: ElevatedButton(
                child: Text('Revisar'),
                onPressed: () {
                  // Navegación a la vista del Botón 1
                  //Navigator.push(
                  //context,
                  //MaterialPageRoute(builder: (context) => Boton1Page()),
                  //);
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.info_outline, color: Colors.blue),
              title: Text('Solicitud de organizacion',
                  style: TextStyle(color: Colors.blue)),
              subtitle: Text(
                  'Las organizaciones permiten conectar a los usuarios de la UC Temuco en ámbitos diferentes a las actividades curriculares regulares.'),
              trailing: ElevatedButton(
                child: Text('Revisar'),
                onPressed: () {
                  // Navegación a la vista del Botón 1
                  //Navigator.push(
                  //context,
                  //MaterialPageRoute(builder: (context) => Boton1Page()),
                  //);
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.info_outline, color: Colors.blue),
              title:
                  Text('ticket INKATUN', style: TextStyle(color: Colors.blue)),
              subtitle: Text(
                  'Plataforma de asistencia técnica y solicitud de servicios UCTemuco.'),
              trailing: ElevatedButton(
                child: Text('Revisar'),
                onPressed: () {
                  // Navegación a la vista del Botón 1
                  //Navigator.push(
                  //context,
                  //MaterialPageRoute(builder: (context) => Boton1Page()),
                  //);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
