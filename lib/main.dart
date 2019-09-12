import 'package:flutter/material.dart';
import 'package:sayit/pages/RegisterPage.dart';

void main() => runApp(SayIt());

class SayIt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Say it',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RegisterPage(),
    );
  }
}
