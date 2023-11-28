import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DocentesPage extends StatelessWidget {
 const DocentesPage({Key? key}) : super(key: key);

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
             color: Colors.black.withOpacity(0.7),
             child: Column(
               children: [
                _buildOptionCard(
                    'Validacion Compromisos de Docencia',
                    'lib/images/virtualizacion.png',
                    context,
                    '/compromisosacademicos'),
                _buildOptionCard('Canales de Apoyo', 'lib/images/canales.png',
                    context, '/canalesDeApoyo'),
                _buildOptionCard(
                    'Programacion Regular Formacion 2023',
                    'lib/images/programacionregular.png',
                    context,
                    '/programacionRegular'),
                _buildOptionCard(
                    'Instancias de Formacion',
                    'lib/images/instancias.png',
                    context,
                    '/instanciasFormacion'),
                _buildOptionCard(
                    'Orientaciones para la Docencia en Linea',
                    'lib/images/orientaciones.png',
                    context,
                    'https://cinap.uct.cl/docentes/#documentos'), // Aquí se ha reemplazado la ruta por la URL
                _buildOptionCard(
                    'Virtualizacion',
                    'lib/images/virtualizacion.png',
                    context,
                    'https://cinap.uct.cl/virtualiza-tu-curso/'), // Aquí se ha reemplazado la ruta por la URL
               ],
             ),
           ),
         ),
       ],
     ),
   );
 }

 Widget _buildOptionCard(String title, String imagePath, BuildContext context, String routeOrUrl) {
   return Padding(
     padding: const EdgeInsets.all(8.0),
     child: Card(
       child: InkWell(
         onTap: () async {
           if (routeOrUrl.startsWith('http')) {
             // Si es una URL, abre el enlace web
             if (await canLaunch(routeOrUrl)) {
               await launch(routeOrUrl);
             } else {
               throw 'No se pudo abrir $routeOrUrl';
             }
           } else {
             // Si no es una URL, navega a la ruta
             Navigator.pushNamed(context, routeOrUrl);
           }
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
