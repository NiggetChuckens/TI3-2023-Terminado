import 'package:flutter/material.dart';

class DocentesPage extends StatelessWidget {
  const DocentesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Docentes'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/images/formacion_docente.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: Column(
                children: [
                  _buildOptionCard('Validacion Compromisos de Docencia',
                      'lib/images/virtualizacion.png'),
                  _buildOptionCard(
                      'Canales de Apoyo', 'lib/images/canales.png'),
                  _buildOptionCard('Programacion Regular Formacion 2023',
                      'lib/images/programacionregular.png'),
                  _buildOptionCard(
                      'Instancias de Formacion', 'lib/images/instancias.png'),
                  _buildOptionCard('Orientaciones para la Docencia en Linea',
                      'lib/images/orientaciones.png'),
                  _buildOptionCard(
                      'Virtualizacion', 'lib/images/virtualizacion.png'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard(String title, String imagePath) {
    return Padding(
      padding:
          const EdgeInsets.all(8.0), // adjust this value to change the space
      child: Card(
        child: InkWell(
          onTap: () {
            // Handle onTap
          },
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black,
                      offset: Offset(5.0, 5.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
