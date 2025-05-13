import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'faq.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DatabaseReference myRTDB = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL:
    "https://fir-auth-4e163-default-rtdb.asia-southeast1.firebasedatabase.app",
  ).ref();

  double temperature = 0.0;
  double humidity = 0.0;
  int soilMoisture = 0;
  int tds = 0;

  List<double> tempData = [];
  List<double> humidityData = [];
  List<double> soilMoistureData = [];
  List<double> tdsData = [];

  @override
  void initState() {
    super.initState();
    _readSensorValues();
  }

  void _readSensorValues() {
    myRTDB.child('Sensor/temperature').onValue.listen((event) {
      final val = event.snapshot.value;
      setState(() {
        temperature = double.tryParse(val.toString()) ?? 0.0;
        _updateDataList(tempData, temperature, 20);
      });
    });

    myRTDB.child('Sensor/humidity').onValue.listen((event) {
      final val = event.snapshot.value;
      setState(() {
        humidity = double.tryParse(val.toString()) ?? 0.0;
        _updateDataList(humidityData, humidity, 20);
      });
    });

    myRTDB.child('Sensor/soilMoisture').onValue.listen((event) {
      final val = event.snapshot.value;
      setState(() {
        soilMoisture = int.tryParse(val.toString()) ?? 0;
        _updateDataList(soilMoistureData, soilMoisture.toDouble(), 20);
      });
    });

    myRTDB.child('Sensor/tds').onValue.listen((event) {
      final val = event.snapshot.value;
      setState(() {
        tds = int.tryParse(val.toString()) ?? 0;
        _updateDataList(tdsData, tds.toDouble(), 20);
      });
    });
  }

  void _updateDataList(List<double> dataList, double newValue, int maxLength) {
    if (dataList.length >= maxLength) {
      dataList.removeAt(0);
    }
    dataList.add(newValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F7FF),
      appBar: AppBar(
        title: const Text('Sensor Dashboard'),
        centerTitle: true,
        backgroundColor: const Color(0xFF79B7FF),
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            tooltip: 'FAQ',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FaqPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SensorChartCard(
              title: 'Temperature (°C)',
              icon: Icons.thermostat,
              color: Colors.orange,
              currentValue: temperature,
              data: tempData,
            ),
            SensorChartCard(
              title: 'Humidity (%)',
              icon: Icons.water_drop,
              color: Colors.blue,
              currentValue: humidity,
              data: humidityData,
            ),
            SensorChartCard(
              title: 'TDS (ppm)',
              icon: Icons.science,
              color: Colors.purple,
              currentValue: tds.toDouble(),
              data: tdsData,
            ),
            SensorChartCard(
              title: 'Soil Moisture',
              icon: Icons.grass,
              color: Colors.green,
              currentValue: soilMoisture.toDouble(),
              data: soilMoistureData,
            ),
          ],
        ),
      ),
    );
  }
}

class SensorChartCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final double currentValue;
  final List<double> data;

  const SensorChartCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.currentValue,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: color.withOpacity(0.1),
                  child: Icon(icon, color: color),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  currentValue.toStringAsFixed(1),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 150,
              child: LineChart(
                LineChartData(
                  minX: 0,
                  maxX: data.isNotEmpty ? (data.length - 1).toDouble() : 1,
                  minY: 0,
                  maxY: data.isNotEmpty
                      ? data.reduce((a, b) => a > b ? a : b) + 10
                      : 100,
                  titlesData: FlTitlesData(show: false),
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      color: color,
                      barWidth: 3,
                      belowBarData: BarAreaData(
                        show: true,
                        color: color.withOpacity(0.3),
                      ),
                      dotData: FlDotData(show: false),
                      spots: data
                          .asMap()
                          .entries
                          .map((e) => FlSpot(
                        e.key.toDouble(),
                        e.value,
                      ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
