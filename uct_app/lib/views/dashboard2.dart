import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:uct_app/components/specialiscard.dart';
import 'package:uct_app/components/categorycards.dart';
class Dash extends StatefulWidget {
  const Dash({Key? key, required this.username}) : super(key: key);
  final String username;

  @override
  State<Dash> createState() => _DashState();
}

class _DashState extends State<Dash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bienvenido,',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        widget.username,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.deepPurple[100],
                    ),
                    child: const Icon(Icons.person),
                  )
                ]),
          ),
          const SizedBox(height: 25),

          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.pink[100],
                    borderRadius: BorderRadius.circular(12)),
                child: Row(children: [
                  Container(
                    height: 100,
                    width: 100,
                    child: Lottie.network(
                        'https://assets10.lottiefiles.com/packages/lf20_tutvdkg0.json'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Como te sientes hoy?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const Text(
                          'Agenda tu cita si lo necesitas',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.deepPurple[300],
                            ),
                            child: const Center(
                              child: Text(
                                'Empezemos',
                                style: TextStyle(color: Colors.white),
                              ),
                            ))
                      ],
                    ),
                  )
                ]),
              )),
          const SizedBox(height: 25),

          //SEARCH BAR
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.deepPurple[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Que estas buscando?',
                  ),
                ),
              )),

          const SizedBox(height: 25),

          //LIST VIEW
          Container(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  Category(
                    categoryName: 'Terapia',
                    iconImagePath: 'lib/images/terapia.png',
                  ),
                  Category(
                    categoryName: 'Psicologia',
                    iconImagePath: 'lib/images/psicologia.png',
                  ),
                  Category(
                    categoryName: 'Psiquiatria',
                    iconImagePath: 'lib/images/psiquiatra.png',
                  ),
                  Category(
                    categoryName: 'Doctor',
                    iconImagePath: 'lib/images/doc.png',
                  ),
                ],
              )),

          const SizedBox(height: 25),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Especialistas',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'Ver todos',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.grey[500]),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),

          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 2.0),
                  height: 20, // Adjust the height as needed
                  child: const Especialista(
                    doctorImagePath: 'lib/images/cj.png',
                    rating: '4.2',
                    doctorName: 'Javier Alcalde',
                    doctorSpecialty: 'Psicologia clínica',
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 2.0),
                  height: 40, // Adjust the height as needed
                  child: const Especialista(
                    doctorImagePath: 'lib/images/doctor1.jpg',
                    rating: '4.7',
                    doctorName: 'Javier Sacristán',
                    doctorSpecialty: 'Terapia de pareja',
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 2.0),
                  height: 40, // Adjust the height as needed
                  child: const Especialista(
                    doctorImagePath: 'lib/images/cj.png',
                    rating: '4.1',
                    doctorName: 'Luis Miguel Jurado',
                    doctorSpecialty: 'Neuropsicología',
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 2.0),
                  height: 100, // Adjust the height as needed
                  child: const Especialista(
                    doctorImagePath: 'lib/images/cj.png',
                    rating: '4.9',
                    doctorName: 'Ismael Jurado',
                    doctorSpecialty: 'Psicología deportiva',
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 2.0),
                  height: 40, // Adjust the height as needed
                  child: const Especialista(
                    doctorImagePath: 'lib/images/cj.png',
                    rating: '4.2',
                    doctorName: 'Diego Vázquez',
                    doctorSpecialty: 'Pediatría',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 100,)
        ],
      )),
    );
  }
}
