import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class programacionRegularPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
        // Lista de URLs
    List<String> urls = [
      'https://cinap.uct.cl/ticlab/',
      'https://cinap.uct.cl/docentes/material-de-apoyo-docente/',
      'https://cinap.uct.cl/organizacion/',
      'https://www.youtube.com/watch?v=dQw4w9WgXcQ'
      // Agregue más URLs aquí
    ];
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 8, 123, 177), // Fondo azul claro
      appBar: AppBar(
        title: Text('Canales de Apoyo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'PROGRAMACIÓN FORMATIVA',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              'Te invitamos revisar y ser parte de la diversa oferta formativa que hemos preparado para ti, revise nuestra programación en marzo 2023',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.0, color: Colors.white),
            ),
            SizedBox(height: 16.0), // Espacio entre el subtítulo y los botones
            Column(
              children: <Widget>[
                Text('Talleres TICLAB', style: TextStyle(color: Colors.white)),
                ElevatedButton(
                  child: Text('>>Mas informacion'),
                   onPressed: () async {
                    if (await canLaunch(urls[0])) {
                      await launch(urls[0]);
                    } else {
                      throw 'No se pudo abrir ${urls[3]}';
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0), // Espacio entre los botones
            Column(
              children: <Widget>[
                Text('Curso de profundización EDUCA Blackboard',
                    style: TextStyle(color: Colors.white)),
                ElevatedButton(
                  child: Text('>>Mas informacion'),
                    onPressed: () async {
                    if (await canLaunch(urls[1])) {
                      await launch(urls[1]);
                    } else {
                      throw 'No se pudo abrir ${urls[3]}';
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0), // Espacio entre los botones
            Column(
              children: <Widget>[
                Text('Formación inicial docente',
                    style: TextStyle(color: Colors.white)),
                ElevatedButton(
                  child: Text('>>Mas informacion'),
                   onPressed: () async {
                    if (await canLaunch(urls[2])) {
                      await launch(urls[2]);
                    } else {
                      throw 'No se pudo abrir ${urls[3]}';
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}