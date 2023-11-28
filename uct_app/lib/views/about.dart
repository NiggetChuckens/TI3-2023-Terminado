import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de Cinap'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Image.asset('lib/images/cinapequipo.jpg'),
            const SizedBox(height: 20.0),
            const Text(
              'Cinap es la unidad encargada de definir e implementar las directrices institucionales para el fortalecimiento del proceso de enseñanza y aprendizaje a través del uso e incorporación de las TIC.',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Esta unidad es responsable del diseño, operación y mejora de los servicios vinculados a la formación de docentes en el uso de TIC, al apoyo en procesos de implementación de innovaciones con recursos pedagógicos mediados por TIC y la creación de recursos tecnológicos para prácticas específicas. De igual forma está a cargo de facilitar los recursos educativos tecnológicos que apoyen los procesos de enseñanza y aprendizaje tanto de docentes como de estudiantes, ya sea en modalidad presencial o a distancia, así como apoyar otras ofertas formativas (articulación enseñanza media, pregrado, postgrado y educación continua) impartidas por la UC Temuco mediadas por tecnologías, Esta dirección nace de la necesidad de potenciar el uso de la tecnología educativa al interior de la Universidad como medio para elevar el impacto de los procesos de formación de los docentes, y en general los de enseñanza y aprendizaje. Para lo anterior, se hace necesario iniciar procesos robustos de formación del profesorado para la integración de las TIC en el currículum; roles, competencias y espacios de formación. Adicionalmente generar recursos educativos para fomentar y potenciar la práctica educativa, la formación online y la innovación educativa.',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}