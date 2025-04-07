import 'package:flutter/material.dart';

class FAQsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQs - Smart Farming System'),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          FAQItem(
            question: "How does the system detect soil moisture levels?",
            answer:
            "The system uses a soil moisture sensor that provides real-time readings. When moisture drops below a threshold, the irrigation pump is triggered automatically.",
          ),
          FAQItem(
            question: "Can I manually control the pump and LED?",
            answer:
            "Yes, you can manually turn the pump and LED on or off from the control panel in the app.",
          ),
          FAQItem(
            question: "How is temperature and humidity monitored?",
            answer:
            "A DHT22 sensor is used to track temperature and humidity inside the farming environment, ensuring optimal conditions.",
          ),
          FAQItem(
            question: "Does the system send notifications?",
            answer:
            "Yes, alerts are sent when sensor readings exceed set thresholds, so you can take action immediately.",
          ),
        ],
      ),
    );
  }
}

class FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        title: Text(
          question,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(answer),
          )
        ],
      ),
    );
  }
}
