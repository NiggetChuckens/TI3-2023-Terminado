import 'package:flutter/material.dart';
import 'data.dart';

class SpecialistsScreen extends StatelessWidget {
  final String category;

  const SpecialistsScreen({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final specialistsByCategory = specialists.where((specialist) => specialist.category == category).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Especialistas de $category'),
      ),
      body: ListView.builder(
        itemCount: specialistsByCategory.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(specialistsByCategory[index].name, style: const TextStyle(fontSize: 20)),
            subtitle: Text(specialistsByCategory[index].category),
            trailing: Text(specialistsByCategory[index].rating.toString()),
            

            
          );
        },
      ),
    );
  }
}