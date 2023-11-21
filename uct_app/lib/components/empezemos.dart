import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelcomeMessageBox extends StatelessWidget {
  final LinearGradient gradient;

  const WelcomeMessageBox({super.key, required this.gradient});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(children: [
          SizedBox(
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
                  'Agenda tu cita',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/especialistas');
                  },
                  child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xFF8FB5E1),
                      ),
                      child: const Center(
                        child: Text(
                          'Empezemos',
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}