
import 'package:flutter/material.dart';
import 'screens/car_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Registration',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CarListScreen(), 
    );
  }
}
