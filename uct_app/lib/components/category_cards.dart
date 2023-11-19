import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  final String iconImagePath;
  final String categoryName;

<<<<<<< HEAD
  const Category({super.key, 
    required this.iconImagePath,
    required this.categoryName,

  });
  
  
=======
  const Category({
    super.key,
    required this.iconImagePath,
    required this.categoryName,
  });

>>>>>>> Dev-Rob
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: Container(
<<<<<<< HEAD
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
=======
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xFF8FB5E1),
          ),
          child: Row(
            children: [
              Image.asset(
                iconImagePath,
                height: 40,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(categoryName),
            ],
          )),
    );
  }
}
>>>>>>> Dev-Rob
