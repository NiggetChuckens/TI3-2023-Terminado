import 'package:flutter/material.dart';
import 'package:uct_app/views/profile_grid.dart';

void main(){
  runApp(
    const MaterialApp(
      title: 'Mi perfil',
      home: SafeArea(
        child: ProfilesGrid(),
        ),
    )
  );
}
