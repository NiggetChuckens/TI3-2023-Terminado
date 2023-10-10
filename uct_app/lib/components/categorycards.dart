import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  final iconImagePath;
  final String categoryName;

  const Category({
    required this.iconImagePath,
    required this.categoryName,

  });
  
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.deepPurple[100],
        ),
          child: Row(children: [
            Image.asset(iconImagePath,
            height: 40,
            ),
            const SizedBox(width: 10,),
            Text(categoryName),
          ],
        )
      ),
    );
  }
}