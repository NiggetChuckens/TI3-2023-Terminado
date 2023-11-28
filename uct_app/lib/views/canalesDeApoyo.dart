// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CanalesDeApoyoPage extends StatelessWidget {
  const CanalesDeApoyoPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de URLs
    List<String> urls = [
      'https://cinap.uct.cl/docentes/#canales-de-apoyo',
      'https://cinap.uct.cl/docentes/material-de-apoyo-docente/',
      'https://cinap.uct.cl/organizacion/',
      'https://inkatun.uct.cl',
      // Agregue más URLs aquí
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Canales de Apoyo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Canales de apoyo',
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan),
            ),
            const Text(
              'En esta sección encontrarás los diferentes tipos de ayuda que tenemos para ti, sobre la configuración y uso tecnológico y pedagógico, de las plataformas LMS de la UCTemuco.',
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
            const SizedBox(
                height: 16.0), // Espacio entre el subtítulo y los botones
            ListTile(
              leading: const Icon(Icons.info_outline, color: Colors.blue),
              title:
                  const Text('Apoyo en linea', style: TextStyle(color: Colors.blue)),
              subtitle: const Text(
                  '-Lunes a viernes\n 09:00 - 11:00 hrs\n -lunes a jueves\n 15:00 - 17:00'),
              trailing: ElevatedButton(
                child: const Text('Revisar'),
                onPressed: () async {
                  if (await canLaunch(urls[0])) {
                    await launch(urls[0]);
                  } else {
                    throw 'No se pudo abrir ${urls[0]}';
                  }
                },
              ),
            ),
            // Repite para los otros tres botornes
            ListTile(
              leading: const Icon(Icons.info_outline, color: Colors.blue),
              title: const Text('material de apoyo docente',
                  style: TextStyle(color: Colors.blue)),
              subtitle: const Text(
                  'a continuacion encontrara material con video y/o infografias para ayudarte a ti como docente a utilizar las plataformas LMS'),
              trailing: ElevatedButton(
                child: const Text('Revisar'),
                onPressed: () async {
                  if (await canLaunch(urls[1])) {
                    await launch(urls[1]);
                  } else {
                    throw 'No se pudo abrir ${urls[1]}';
                  }
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.info_outline, color: Colors.blue),
              title: const Text('Solicitud de organizacion',
                  style: TextStyle(color: Colors.blue)),
              subtitle: const Text(
                  'Las organizaciones permiten conectar a los usuarios de la UC Temuco en ámbitos diferentes a las actividades curriculares regulares.'),
              trailing: ElevatedButton(
                child: const Text('Revisar'),
                onPressed: () async {
                  if (await canLaunch(urls[2])) {
                    await launch(urls[2]);
                  } else {
                    throw 'No se pudo abrir ${urls[2]}';
                  }
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.info_outline, color: Colors.blue),
              title:
                  const Text('ticket INKATUN', style: TextStyle(color: Colors.blue)),
              subtitle: const Text(
                  'Plataforma de asistencia técnica y solicitud de servicios UCTemuco.'),
              trailing: ElevatedButton(
                child: const Text('Revisar'),
                onPressed: () async {
                  if (await canLaunch(urls[3])) {
                    await launch(urls[3]);
                  } else {
                    throw 'No se pudo abrir ${urls[3]}';
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
