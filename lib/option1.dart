import 'package:flutter/material.dart';

class Option1Page extends StatelessWidget {
  const Option1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Option 1'),
      ),
      body: const Center(
        child: Text('Option 1 Page'),
      ),
    );
  }
}
