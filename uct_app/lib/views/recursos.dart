import 'package:flutter/material.dart';

class RecursosPage extends StatelessWidget {
  const RecursosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recursos'),
      ),
      body: const Center(
        child: Text('This is the Recursos Page'),
      ),
    );
  }
}
