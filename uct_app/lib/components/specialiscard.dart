import 'package:flutter/material.dart';
import 'package:uct_app/components/cards.dart';
class Especialista extends StatelessWidget {
  final String doctorImagePath;
  final String rating;
  final String doctorName;
  final String doctorSpecialty;

  const Especialista({super.key, 
    required this.doctorImagePath,
    required this.rating,
    required this.doctorName,
    required this.doctorSpecialty,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EspecialistaDetails(
              doctorImagePath: doctorImagePath,
              rating: rating,
              doctorName: doctorName,
              doctorSpecialty: doctorSpecialty,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.deepPurple[100],
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  doctorImagePath,
                  height: 100,
                  width: 100,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow[700],
                  ),
                  Text(
                    rating,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                doctorName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                doctorSpecialty,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}