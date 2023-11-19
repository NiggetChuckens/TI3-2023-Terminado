import 'package:flutter/material.dart';
import 'package:uct_app/components/specialists.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uct_app/views/calendario.dart';

class EspecialistaDetails extends StatefulWidget {
  final Specialist specialist;

  const EspecialistaDetails({Key? key, required this.specialist})
      : super(key: key);

  @override
  EspecialistaDetailsState createState() => EspecialistaDetailsState();
}

class EspecialistaDetailsState extends State<EspecialistaDetails> {
  void _launchMailClient(String email) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Consulta%20DTE',
    );

    String url = params.toString();
    if (await canLaunchUrl(params)) {
      await launchUrl(params);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                    child: Image.asset(
                      'lib/images/doctor1.jpg', // replace with your static image path
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.specialist.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Color.fromARGB(255, 16, 13, 20),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.specialist.rol,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Especialidad en:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                        color: Color.fromARGB(255, 16, 13, 20),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.specialist.especialidad,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          print(
                              "Email for attendees: ${widget.specialist.email}");
                          "Name for attendees: ${widget.specialist.name}";
                          Navigator.pushNamed(
                            context,
                            '/calendario',
                            arguments: {
                              'email': widget.specialist.email,
                              'name': widget.specialist.name,
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Agendar cita',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 1),
                    Center(
                      child: ElevatedButton(
                        onPressed: () =>
                            _launchMailClient(widget.specialist.email),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Correo',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
