import 'package:flutter/material.dart';

class SensorPage extends StatelessWidget {
  final String title;

  SensorPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$title Data')),
      body: Center(
        child: Text(
          'Real-time data for $title',
          style: TextStyle(fontSize: 20,color: Colors.black),
        ),
      ),
    );
  }
}
