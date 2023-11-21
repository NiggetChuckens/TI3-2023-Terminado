import 'package:flutter/material.dart';

class CursoEduca extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue, // Fondo azul claro
      appBar: AppBar(
        backgroundColor: Colors.lightBlue, // Fondo azul claro
        title: Text('Curso de profundización EDUCA Blackboard\nCuatro cursos dictados en modalidad online, que buscan profundizar los conceptos de rúbrica, cuestionarios, uso de las herramientas Ally y SafeAssing disponibles en el LMS institucional, EDUCA Blackboard.', style: TextStyle(color: Colors.white)), // Título en blanco
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white), // Letras en blanco
            ),
            SizedBox(height: 16.0), // Espacio entre el título y los cuadros de texto
            Container(
              color: Colors.lightBlue, // Fondo azul claro
              child: Column(
                children: <Widget>[
                  Text('Rúbricas\nCurso orientado a la creación y asociación de rúbricas en actividades de un curso, que permitan\n al docente garantizar una calificación imparcial y coherente, de tal manera \nque los estudiantes se centren en sus expectativas de aprendizaje.', style: TextStyle(color: Colors.white)), // Letras en blanco
                  ElevatedButton(
                    child: Text('>>inscribirme'),
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
                        SizedBox(height: 16.0), // Espacio entre el título y los cuadros de texto
            Container(
              color: Colors.lightBlue, // Fondo azul claro
              child: Column(
                children: <Widget>[
                  Text('Uso de Ally\nCurso orientado a mejorar la accesibilidad de los contenidos digitales de un curso,\n comprendiendo el desempeño de Ally en forma proactiva para:\n– Revisar automáticamente que los materiales del curso cumplan con los estándares de accesibilidad.\n', style: TextStyle(color: Colors.white)), // Letras en blanco
                  ElevatedButton(
                    child: Text('>>inscribirme'),
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
                       Container(
              color: Colors.lightBlue, // Fondo azul claro
              child: Column(
                children: <Widget>[
                  Text('Uso de SafeAssign\nCurso orientado al uso de SafeAssign para la revisión de la producción de contenidos digitales de los estudiantes,\n comparando las tareas enviadas con respecto a un conjunto de documentos académicos e identificar áreas que\n coinciden entre las tareas enviadas y los trabajos existentes. Como elemento disuasorio y como herramienta educativa.', style: TextStyle(color: Colors.white)), // Letras en blanco
                  ElevatedButton(
                    child: Text('>>inscribirme'),
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
                  Text('Cuestionarios\nCurso orientado al diseño e implementación de cuestionarios en un curso de EDUCA Blackboard, \nque permita al docente evaluar aprendizajes, medir progresos, analizar\n el rendimiento de sus estudiantes. Y retroalimentar en forma oportuna.', style: TextStyle(color: Colors.white)), // Letras en blanco
                  ElevatedButton(
                    child: Text('>>inscribirme'),
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
