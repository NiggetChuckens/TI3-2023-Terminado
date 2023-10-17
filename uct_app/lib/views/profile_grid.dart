import 'package:flutter/material.dart';
import 'package:uct_app/components/data.dart';
import 'package:uct_app/components/about.dart'; // Import the about.dart file

class ProfilesGrid extends StatelessWidget {
  const ProfilesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ayudantias disponibles',
          style: TextStyle(
            color: Color.fromARGB(255, 221, 221, 221),
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 5.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    title: Text('Information'),
                    content: Text('Aqui se muestran los especialistas disponibles para ayudarte en tu proceso de aprendizaje y desarrollo'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Cerrar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/images/cnfondo.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: specialists.length,
                itemBuilder: (BuildContext context, int index) {
                  final specialist = specialists[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EspecialistaDetails(
                            doctorImagePath: specialist.image,
                            rating: specialist.rating.toString(),
                            doctorName: specialist.name,
                            doctorSpecialty: specialist.category,
                          ),
                        ),
                      );
                    },
                    child: Center(
                      child: SizedBox(
                        width: 150, // Set your desired width here
                        child: Card(
                          color: const Color.fromARGB(
                              255, 42, 42, 42), // Dark background for the card
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 4.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      10.0), // Adjust the border radius as needed
                                  child: Image.asset(
                                    specialist.image,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  specialist.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(
                                        0xFFE0E0E0), // Light text color for contrast
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  specialist.category,
                                  style: const TextStyle(
                                    color: Color(
                                        0xFF757575), // Slightly lighter grey for contrast
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      const Icon(
                                        Icons.star, // This is the star icon
                                        color: Color.fromARGB(255, 224, 217,
                                            118), // Set the color of the star icon
                                      ),
                                      Text(
                                        ' ${specialist.rating}', // Add a space before the rating to separate it from the star icon
                                        style: const TextStyle(
                                          color: Color.fromARGB(255, 224, 217,
                                              118), // Set the color of the rating text
                                          fontWeight: FontWeight
                                              .bold, // Make the rating text bold
                                        ),
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
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
