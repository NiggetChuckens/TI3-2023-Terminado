import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uct_app/components/download_card.dart';

class CompromisosAcademicosPage extends StatelessWidget {
  CompromisosAcademicosPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final List<String> titles = [
    'TRANSFORMACIÓN DE CURSO: GENERAL',
    'TRANSFORMACIÓN DE CURSO: VIRTUALIZACIÓN DE CURSOS',
    'ELABORACIÓN DE RECURSOS PARA EL APRENDIZAJE',
    'ELABORACIÓN DE RECURSOS EDUCATIVOS DIGITALES',
    'EVALUACIÓN TRABAJO COLABORATIVO: COMUNIDADES DE APRENDIZAJE',
  ];
  final List<String> urls = [
    'https://cinap.uct.cl/wp-content/uploads/2023/09/1-TRANSFORMACION-DE-CURSO-GENERAL-B1.docx',
    'https://cinap.uct.cl/wp-content/uploads/2023/09/2-TRANSFORMACION-DE-CURSOS-VIRTUALIZACION-DE-CURSO-vf.docx',
    'https://cinap.uct.cl/wp-content/uploads/2023/09/3-ELABORACION-DE-RECURSOS-PARA-EL-APRENDIZAJE.docx',
    'https://cinap.uct.cl/wp-content/uploads/2023/09/4-ELABORACION-DE-RECURSOS-EDUCATIVOS-DIGITALES-2.docx',
    'https://cinap.uct.cl/wp-content/uploads/2023/09/5_EVALUACION-TRABAJO-COLABORATIVO.docx',
  ];

  List<DownloadCard> downloadCards = [];

  ///List<DownloadCard>.generate(
  ///  titles.length,
  ///  (index) => DownloadCard(coursename: titles[index], url: urls[index], filename: files[index])
  ///);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compromisos Academicos'),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    'lib/images/compromisos-academicos.jpg'), // replace with your image path
                fit: BoxFit.cover,
                alignment: Alignment.centerRight,
                opacity: 0.5),
          ),
          child: Opacity(
            opacity: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text('Validacion de Compromisos Academicos 2023',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text('Compromisos academicos 2023',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                        'Para solicitar la validación de productos del CINAP (Centro de Innovación en Aprendizaje Docencia y Tecnología Educativa), realice los siguientes pasos:'),
                  ),
                  // Add this line at the top of your file
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        const url =
                            "https://cinap.uct.cl/wp-content/uploads/2023/09/Tabla-de-compromisos_2023.pdf";
                        const intentUrl =
                            "intent://#Intent;scheme=http;package=com.android.chrome;end";
                        if (await canLaunch(intentUrl)) {
                          await launch(intentUrl);
                        } else if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch ';
                        }
                      },
                      child: const Text('Ver tabla de compromisos académicos'),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                        'Recepción de documentación: hasta 30 de noviembre 2023'),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                        'Envío de constancias DTE-CeDID: entre 15  y 20 de diciembre 2023'),
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'PASO 1.- Utilice las fichas disponibles, dependiendo del Producto a validar:\n',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        '- FICHA TRANSFORMACIÓN DE CURSOS: GENERAL (Sólo si no trabaja con el CINAP)\n\n'
                        '- FICHA TRANSFORMACIÓN DE CURSO: VIRTUALIZACIÓN DE CURSOS (Sólo si no trabaja con el CINAP)\n\n'
                        '- FICHA ELABORACIÓN DE RECURSOS PARA EL APRENDIZAJE\n\n'
                        '- FICHA ELABORACIÓN DE RECURSOS EDUCATIVOS DIGITALES (Sólo si no trabaja con el CINAP)\n\n'
                        '- FICHA EVALUACIÓN TRABAJO COLABORATIVO: COMUNIDADES DE APRENDIZAJE\n\n',
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'Se aportan también documentos orientadores:\n',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        '- DOCUMENTO ORIENTADOR: CRITERIOS DE CALIDAD PARA LA PRODUCCIÓN DE CONTENIDOS VIRTUALES\n\n'
                        '- DOCUMENTO ORIENTADOR: PAUTA PARA LA EVALUACIÓN DE RECURSOS EDUCATIVOS DIGITALES\n\n'
                        '- DOCUMENTO ORIENTADOR: PAUTA DE RETROALIMENTACIÓN DE GUÍA DE APRENDIZAJE',
                      ),
                    ),
                  ),

                  const SizedBox(height: 80),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      color: const Color.fromARGB(
                          94, 31, 156, 240), // Replace with your desired color
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: CarouselSlider(
                          options: CarouselOptions(
                            aspectRatio: 2.0,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                            autoPlay: true,
                            height: 150,
                          ),
                          items: downloadCards = List<DownloadCard>.generate(
                              titles.length,
                              (index) => DownloadCard(
                                  coursename: titles[index], url: urls[index])),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 80),

                  const Text(
                      'PASO 2.- Complete el formulario, y adjunte la(s) ficha(s) según corresponda, antes de enviar.\n\n'
                      'Recuerde: Dentro de la ficha, incorpore un LINK válido para el PRODUCTO que elaboró. \n\n'
                      'Asegúrese que esté público para poder visualizarlo'),
                  const SizedBox(height: 40),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Nombre',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Este campo es obligatorio';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Rut',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Este campo es obligatorio';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Email',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Este campo es obligatorio';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Facultad',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Este campo es obligatorio';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                            decoration: const InputDecoration(
                          labelText: 'Tipo de producto',
                        )),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Formulario enviado'),
                                ),
                              );
                            }
                          },
                          child: const Text('Enviar'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
