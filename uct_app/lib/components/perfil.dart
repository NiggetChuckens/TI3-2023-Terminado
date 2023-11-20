import 'package:flutter/material.dart';


class ProfilePopup extends StatelessWidget {
  final String email;
  final String name;
  final String profilePicture;
  final String grado;
  final String rol;
  final String especialidad;


  const ProfilePopup({super.key, required this.email, required this.name, required this.profilePicture, required this.grado, required this.rol, required this.especialidad});

  @override
  Widget build(BuildContext context) {
 return Theme(
 data: ThemeData(
   dialogBackgroundColor: Colors.transparent,
 ),
 child: Dialog(
   shape: RoundedRectangleBorder(
     borderRadius: BorderRadius.circular(50.0),
   ),
   child: Container(
     decoration: BoxDecoration(
       gradient: const LinearGradient(
         begin: Alignment.topCenter,
         end: Alignment.bottomCenter,
         colors: [
           Color(0xFFD190E0),
           Color(0xFF8FB5E1),
         ],
       ),
       borderRadius: BorderRadius.circular(20.0),
     ),
     padding: const EdgeInsets.all(20),
     child: Column(
       mainAxisSize: MainAxisSize.min,
       children: [
         ClipRRect(
           borderRadius: BorderRadius.circular(10.0),
           child: Image.network(profilePicture),
         ),
         const SizedBox(height: 10,),
         Text(
           name,
           style: const TextStyle(
             fontSize: 24,
             fontWeight: FontWeight.bold,
             color: Color.fromARGB(255, 16, 13, 20),
           ),
         ),
         const SizedBox(height: 5,),
         Text(
           email,
           style: const TextStyle(
             color: Color.fromARGB(255, 81, 81, 81),
             fontSize: 18,
           ),
         ),
         const SizedBox(height: 5,),
         Text(
           grado,
           style: const TextStyle(
             color: Color.fromARGB(255, 81, 81, 81),
             fontSize: 18,
           ),
         ),
         const SizedBox(height: 5,),
         Text(
           rol,
           style: const TextStyle(
             color: Color.fromARGB(255, 81, 81, 81),
             fontSize: 18,
           ),
         ),
         const SizedBox(height: 5,),
         SizedBox(
  width: 300, // Set the width as per your requirement
  child: Text(
    especialidad,
    textAlign: TextAlign.center,
    style: const TextStyle(
      color: Color.fromARGB(255, 81, 81, 81),
      fontSize: 18,
    ),
  ),
),
         const SizedBox(height: 10,),
         ElevatedButton(
           style: ElevatedButton.styleFrom(
             backgroundColor: Colors.deepPurple,
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(20),
             ),
           ),
           child: const Text(
             'Agendar Cita',
             style: TextStyle(
               fontWeight: FontWeight.bold,
               fontSize: 18,
             ),
           ),
           onPressed: () {
             Navigator.pushNamed(
               context,
               '/calendario',
               arguments: {
                'email': email,
                'name': name,
               },
             );
           },
         ),
         
       ],
     ),
   ),
 )
);


}

}