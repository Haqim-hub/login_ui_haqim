import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Developer Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture with Border
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blueAccent, width: 2),
              ),
              child: CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/profile.jpg'), // Replace with your image
              ),
            ),
            SizedBox(height: 15),

            Text(
              'Aisyah Zamberi',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Class: 4B',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            Text(
              'Age: 20',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 20),

            Text(
              '🎓 KKTM Petaling Jaya - Diploma in Electronic Engineering',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 25),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Project Overview',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 15),

            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
                ],
                image: DecorationImage(
                  image: AssetImage('assets/project.jpg'), // Replace with your image
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 15),

            Text(
              '📡 This Smart Monitoring project focuses on real-time environmental monitoring using IoT technology. '
                  'It utilizes sensors such as DHT22 for temperature & humidity, MQ135 for air quality, '
                  'and soil moisture sensors to track environmental changes. '
                  'The ESP32-CAM captures real-time images uploaded via Telegram, '
                  'providing a comprehensive dashboard for efficient smart monitoring. '
                  'This system is designed to optimize automation and provide insights for data-driven decision-making.',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16, color: Colors.grey[800], height: 1.5),
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
