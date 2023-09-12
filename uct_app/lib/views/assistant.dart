import 'package:flutter/material.dart';

class Assistant extends StatelessWidget {
  const Assistant({Key? key, this.username, this.picture}) : super(key: key);
  final String? username;
  final String? picture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: 
          Column(
            children: [
                Column(
                  children: [
                    Image.network(
                      '$picture',
                      width: 140,
                      height: 140,
                    ),
                  Text('$username'),
              ]
            ),
            ],
            ),
          );
  }
}