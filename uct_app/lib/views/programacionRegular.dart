import 'package:flutter/material.dart';

class programacionRegularPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
<<<<<<< HEAD
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
=======
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
>>>>>>> Dev-Nico
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
                  child: Text('Revisar'),
                  onPressed: () {
<<<<<<< HEAD
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => talleresTiclab()),
                    );
=======
                    // Navegación a la vista del Botón 1
                    //Navigator.push(
                    //context,
                    //MaterialPageRoute(builder: (context) => Boton1Page()),
                    //);
>>>>>>> Dev-Nico
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0), // Espacio entre los botones
            Column(
              children: <Widget>[
<<<<<<< HEAD
                Text('Curso de profundización EDUCA Blackboard', style: TextStyle(color: Colors.white)),
                ElevatedButton(
                  child: Text('Revisar'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CursoEduca()),
                    );
=======
                Text('Curso de profundización EDUCA Blackboard',
                    style: TextStyle(color: Colors.white)),
                ElevatedButton(
                  child: Text('Revisar'),
                  onPressed: () {
                    // Navegación a la vista del Botón 2
                    //Navigator.push(
                    //context,
                    //MaterialPageRoute(builder: (context) => Boton2Page()),
                    //);
>>>>>>> Dev-Nico
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0), // Espacio entre los botones
            Column(
              children: <Widget>[
<<<<<<< HEAD
                Text('Formación inicial docente', style: TextStyle(color: Colors.white)),
                ElevatedButton(
                  child: Text('Revisar'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Formacioninicialdocente()),
                    );
=======
                Text('Formación inicial docente',
                    style: TextStyle(color: Colors.white)),
                ElevatedButton(
                  child: Text('Revisar'),
                  onPressed: () {
                    // Navegación a la vista del Botón 3
                    //              Navigator.push(
                    //               context,
                    //              MaterialPageRoute(builder: (context) => Boton3Page()),
                    //           );
>>>>>>> Dev-Nico
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
<<<<<<< HEAD
}

class talleresTiclab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Talleres TICLAB'),
      ),
      body: Center(
        child: Text('Talleres TICLAB'),
      ),
    );
  }
}

class CursoEduca extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva Vista 2'),
      ),
      body: Center(
        child: Text('Esta es la Nueva Vista 2'),
      ),
    );
  }
}

class Formacioninicialdocente extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formacióninicialdocente '),
      ),
      body: Center(
        child: Text('Formacióninicialdocente'),
      ),
    );
  }
=======
>>>>>>> Dev-Nico
}