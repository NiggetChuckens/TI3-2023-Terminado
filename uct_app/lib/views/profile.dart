import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({
    Key? key,
    required this.username,
    required this.picture,
    required this.description,
    required this.service,
    required this.email,
    required this.experience,
    required this.schedule,
    required this.comment,
  }) : super(key: key);

  final String username;
  final String picture;
  final String description;
  final String email;
  final String service;
  final String experience;
  final String schedule;
  final String comment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.yellow],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text('Perfil de $username'),
      ),
      body: 
        Column(children: [
          Center(
              child: Container(
              padding: const EdgeInsets.all(16.0),
              height: 200,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column( children:[
                    Text(
                        username,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    const SizedBox(height: 1),
                    Image.network(
                      picture,
                      width: 100,
                      height: 120,
                        ),
                      ],
                    ),
                  Column(
                    children: [
                      const SizedBox(height: 35),
                      SizedBox(
                        width: 250,
                        child: 
                          Text(
                          description,
                          style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      const SizedBox(height: 40),
                      Text(
                        email,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),            
                    ],
                  ),
                ],
              ),
            ),
          ),  
            Column( children: [ 
              Center(
                child: Container( 
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color:
                        Colors.amberAccent[700], // change this color to your liking
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min, // to make the column as small as possible
                    mainAxisAlignment: MainAxisAlignment.center, // to make the column as small as possible
                    children: [
                      Column(
                        children: [
                          //Service description
                          const SizedBox(height: 16),
                          Text(
                            'Descripción del servicio',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: 350,
                            child: 
                              Text(
                              service,
                              style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          const SizedBox(height: 50),
                          //Professional experience
                          Text(
                            'Experiencia profesional',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: 350,
                            child: 
                              Text(
                              experience,
                              style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          const SizedBox(height: 50),
                          //Schedule
                          Text(
                            'Horario de atención',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: 350,
                            child:
                              Center(
                                child: Text(
                                schedule,
                                style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ), 
                              
                            ),
                          const SizedBox(height: 50),
                          
                          //here goes a divider
                              
                          //Rating system
                          //Comments
                          Text(
                            'Comentarios',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: 350,
                            child: 
                              Center( 
                                child:
                                  Text(
                                  comment,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                            ),
                          //Functions
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
          ],
        ),
        
    );
  }
}
