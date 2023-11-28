import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactScreen extends StatelessWidget {
  ContactScreen({Key? key}) : super(key: key);

  final links = {
    'UCTemuco': 'http://www.uct.cl',
    'EDUCA Blackboard': 'http://educa.uct.cl',
    'EDUCA Moodle': 'http://moodle.uct.cl',
    'INKATUN': 'http://inkatun.uct.cl',
    'Inspira': 'http://inspira.uct.cl',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 250,
              child: Image.asset(
                'lib/images/Logo_UCT.png',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Estamos Contigo',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Contáctanos:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: const Icon(Icons.phone, color: Colors.blue),
                  title: const Text('Phone', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: const Text('+56 452 205 453'),
                  onTap: () => launchUrlString('tel:+56452205453'),
                ),
                ListTile(
                  leading: const Icon(Icons.email, color: Colors.blue),
                  title: const Text('Email', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: const Text('cinap@uct.cl'),
                  onTap: () => launchUrlString('mailto:cinap@uct.cl'),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Links de interés:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ...links.entries.map((entry) => ListTile(
                  leading: const Icon(Icons.link, color: Colors.blue),
                  title: Text(entry.key, style: const TextStyle(fontWeight: FontWeight.bold)),
                  onTap: () => launchUrlString(entry.value),
                )).toList(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}