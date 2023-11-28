// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VistaConImagen extends StatelessWidget {
  const VistaConImagen({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de URLs
    List<String> urls = [
      'https://cinap.uct.cl/virtualiza-tu-curso/',
      'https://cinap.uct.cl/taller-de-estrategia-coil/',
      'https://cinap.uct.cl/conversatorio-blackte/',
      'https://cinap.uct.cl/educacionpodcast/',
      'https://cinap.uct.cl/espacio-webinar/',
      'https://cinap.uct.cl/somos-digital/',
      // Agregue más URLs aquí
    ];

    return Scaffold(
      backgroundColor:
          Colors.lightBlue, // Cambia el color de fondo a azul claro
      appBar: AppBar(
        title: const Text('instancias formacion'),
      ),
      body: GridView.builder(
        itemCount: 6,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Número de columnas
        ),
        itemBuilder: (context, index) {
          // Lista de rutas de las imágenes
          List<String> rutasImagenes = [
            'lib/images/virtualizatucurso.png',
            'lib/images/tallerestrategia.png',
            'lib/images/conversatorio.png',
            'lib/images/podcast.png',
            'lib/images/espaciowebinar.png',
            'lib/images/somosdigital.png',
          ];

          return _crearImagen(context, rutasImagenes[index], index, urls);
        },
      ),
    );
  }

  Widget _crearImagen(
      BuildContext context, String rutaImagen, int index, List<String> urls) {
    return GestureDetector(
      onTap: () async {
        if (await canLaunch(urls[index])) {
          await launch(urls[index]);
        } else {
          throw 'No se pudo abrir ${urls[index]}';
        }
      },
      child: Container(
        margin: const EdgeInsets.all(8.0), // Agrega un espacio entre las imágenes
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black, // Color del borde
            width: 3.0, // Ancho del borde
          ),
          borderRadius:
              BorderRadius.circular(15.0), // Redondea las esquinas de la imagen
        ),
        child: ClipRRect(
          borderRadius:
              BorderRadius.circular(15.0), // Redondea las esquinas de la imagen
          child: Image.asset(
            rutaImagen,
            width: 100, // Ajusta el ancho de la imagen
            height: 100, // Ajusta la altura de la imagen
            fit: BoxFit.cover, // Ajusta la proporción de la imagen
          ),
        ),
      ),
    );
  }
}
