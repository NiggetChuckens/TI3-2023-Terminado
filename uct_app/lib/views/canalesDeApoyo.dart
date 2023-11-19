import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:url_launcher/url_launcher.dart';
=======
>>>>>>> Dev-Nico

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
<<<<<<< HEAD
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.cyan),
=======
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan),
>>>>>>> Dev-Nico
            ),
            Text(
              'En esta sección encontrarás los diferentes tipos de ayuda que tenemos para ti, sobre la configuración y uso tecnológico y pedagógico, de las plataformas LMS de la UCTemuco.',
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
            SizedBox(height: 16.0), // Espacio entre el subtítulo y los botones
            ListTile(
              leading: Icon(Icons.info_outline, color: Colors.blue),
<<<<<<< HEAD
              title: Text('Apoyo en linea', style: TextStyle(color: Colors.blue)),
              subtitle: Text('-Lunes a viernes\n 09:00 - 11:00 hrs\n -lunes a jueves\n 15:00 - 17:00'),
              trailing: ElevatedButton(
                child: Text('Revisar'),
                onPressed: () {
                  _launchURL('https://us.bbcollab.com/collab/ui/session/guest/fa4c02fa97be41588b50555f7e670cce');
=======
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
>>>>>>> Dev-Nico
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.info_outline, color: Colors.blue),
<<<<<<< HEAD
              title: Text('material de apoyo docente', style: TextStyle(color: Colors.blue)),
              subtitle: Text('a continuacion encontrara material con video y/o infografias para ayudarte a ti como docente a utilizar las plataformas LMS'),
              trailing: ElevatedButton(
                child: Text('Revisar'),
                onPressed: () {
                  _launchURL('link no disponible');
=======
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
>>>>>>> Dev-Nico
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.info_outline, color: Colors.blue),
<<<<<<< HEAD
              title: Text('Solicitud de organizacion', style: TextStyle(color: Colors.blue)),
              subtitle: Text('Las organizaciones permiten conectar a los usuarios de la UC Temuco en ámbitos diferentes a las actividades curriculares regulares.'),
              trailing: ElevatedButton(
                child: Text('Revisar'),
                onPressed: () {
                  _launchURL('link no disponible');
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.info_outline, color: Colors.blue),
              title: Text('ticket INKATUN', style: TextStyle(color: Colors.blue)),
              subtitle: Text('Plataforma de asistencia técnica y solicitud de servicios UCTemuco.'),
              trailing: ElevatedButton(
                child: Text('Revisar'),
                onPressed: () {
                  _launchURL('https://inkatun.uct.cl');
=======
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
>>>>>>> Dev-Nico
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
<<<<<<< HEAD

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo lanzar $url';
    }
  }
=======
>>>>>>> Dev-Nico
}
