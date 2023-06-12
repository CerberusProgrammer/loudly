import 'package:flutter/material.dart';
import 'package:loudly/screen/home.dart';

void main() async {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Loudly',
      theme: ThemeData(
        colorSchemeSeed: Colors.orange,
        useMaterial3: true,
      ),
      home: const Home(),
    ),
  );
}
