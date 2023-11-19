import 'package:flutter/material.dart';
<<<<<<< HEAD

class EspecialistaDetails extends StatefulWidget {
  final String doctorImagePath;
  final String rating;
  final String doctorName;
  final String doctorSpecialty;

  const EspecialistaDetails({super.key, 
    required this.doctorImagePath,
    required this.rating,
    required this.doctorName,
    required this.doctorSpecialty,
  });
=======
import 'package:uct_app/components/specialists.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uct_app/views/calendario.dart';

class EspecialistaDetails extends StatefulWidget {
  final Specialist specialist;

  const EspecialistaDetails({Key? key, required this.specialist})
      : super(key: key);
>>>>>>> Dev-Rob

  @override
  EspecialistaDetailsState createState() => EspecialistaDetailsState();
}

class EspecialistaDetailsState extends State<EspecialistaDetails> {
<<<<<<< HEAD
=======
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

>>>>>>> Dev-Rob
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
<<<<<<< HEAD
                      widget.doctorImagePath,
=======
                      'lib/images/doctor1.jpg', // replace with your static image path
>>>>>>> Dev-Rob
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
<<<<<<< HEAD
                      widget.doctorName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.deepPurple,
=======
                      widget.specialist.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Color.fromARGB(255, 16, 13, 20),
>>>>>>> Dev-Rob
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
<<<<<<< HEAD
                      widget.doctorSpecialty,
=======
                      widget.specialist.rol,
>>>>>>> Dev-Rob
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 16),
<<<<<<< HEAD
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow[700],
                        ),
                        Text(
                          widget.rating,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Acerca de',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod, velit vel bibendum bibendum, elit sapien bibendum sapien, vel bibendum sapien sapien vel sapien. Sed euismod, velit vel bibendum bibendum, elit sapien bibendum sapien, vel bibendum sapien sapien vel sapien.',
                      style: TextStyle(
=======
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
>>>>>>> Dev-Rob
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
<<<<<<< HEAD
                        onPressed: () {Navigator.pushNamed(context, '/calendario');},
=======
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
>>>>>>> Dev-Rob
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
<<<<<<< HEAD
                    const SizedBox(height: 16),
                  ],
                ),
              ),
=======
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
>>>>>>> Dev-Rob
            ],
          ),
        ),
      ),
    );
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> Dev-Rob
