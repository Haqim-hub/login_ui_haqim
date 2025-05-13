import 'package:flutter/material.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensor FAQ'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        children: const [
          SectionTitle(title: '🌡️ DHT22 Sensor'),
          FaqTile(
            question: 'What does the DHT22 sensor measure?',
            answer: 'The DHT22 measures temperature and relative humidity in the environment.',
          ),
          FaqTile(
            question: 'What is the temperature and humidity range of DHT22?',
            answer: 'Temperature: -40°C to +80°C (±0.5°C), Humidity: 0% to 100% RH (±2% to 5%).',
          ),
          FaqTile(
            question: 'How often can it update data?',
            answer: 'Every 2 seconds (0.5 Hz refresh rate).',
          ),
          FaqTile(
            question: 'How is it different from DHT11?',
            answer: 'DHT22 is more accurate and supports a wider range of temperature and humidity.',
          ),
          FaqTile(
            question: 'What are common problems with DHT22?',
            answer: 'Incorrect wiring, needs a pull-up resistor (10kΩ), slow reading interval.',
          ),

          SectionTitle(title: '🌱 Soil Moisture Sensor'),
          FaqTile(
            question: 'What does a soil moisture sensor measure?',
            answer: 'It detects the volumetric water content of the soil.',
          ),
          FaqTile(
            question: 'What kind of values does it produce?',
            answer: 'It gives analog voltage values. Wet soil = Low value, Dry soil = High value.',
          ),
          FaqTile(
            question: 'Can it be left in the soil permanently?',
            answer: 'Not recommended, as the probes corrode over time. Use capacitive sensors instead.',
          ),
          FaqTile(
            question: 'How to interpret the readings?',
            answer: 'Wet = ~300, Dry = ~800. Calibrate based on your soil type.',
          ),
          FaqTile(
            question: 'How to increase sensor lifespan?',
            answer: 'Power it only when reading. Use capacitive sensors for long-term use.',
          ),

          SectionTitle(title: '💧 TDS Sensor'),
          FaqTile(
            question: 'What does a TDS sensor measure?',
            answer: 'It measures the concentration of dissolved solids in water (in ppm).',
          ),
          FaqTile(
            question: 'What is a normal TDS value for plants or hydroponics?',
            answer: '500 – 1200 ppm depending on plant type.',
          ),
          FaqTile(
            question: 'Can TDS sensors be used in pure/distilled water?',
            answer: 'No, they require conductive ions to work.',
          ),
          FaqTile(
            question: 'How to calibrate a TDS sensor?',
            answer: 'Use a TDS calibration solution (e.g., 342 ppm) and adjust the calibration factor.',
          ),
          FaqTile(
            question: 'Can temperature affect TDS readings?',
            answer: 'Yes. Use temperature compensation for more accurate readings.',
          ),
        ],
      ),
    );
  }
}

class FaqTile extends StatelessWidget {
  final String question;
  final String answer;

  const FaqTile({
    required this.question,
    required this.answer,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: ExpansionTile(
        collapsedIconColor: Colors.green,
        iconColor: Colors.green,
        childrenPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        title: Text(
          question,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        children: [
          Text(
            answer,
            style: TextStyle(color: Colors.grey[700], fontSize: 15),
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
    );
  }
}
