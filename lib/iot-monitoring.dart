import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:login_ui_copy2/dashboard.dart';
import 'package:login_ui_copy2/profilepage.dart';

class IotMonitoring extends StatefulWidget {
  const IotMonitoring({super.key});

  @override
  State<IotMonitoring> createState() => _IotMonitoringState();
}

class _IotMonitoringState extends State<IotMonitoring> with SingleTickerProviderStateMixin {
  final DatabaseReference myRTDB = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: "https://fir-auth-4e163-default-rtdb.asia-southeast1.firebasedatabase.app",
  ).ref();

  double temperature = 0.0;
  double humidity = 0.0;
  int soilMoisture = 0;
  int tds = 0;
  bool pumpState = false;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _readSensorValues();

    // Animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _readSensorValues() {
    myRTDB.child('Sensor/temperature').onValue.listen((event) {
      final val = event.snapshot.value;
      setState(() {
        temperature = double.tryParse(val.toString()) ?? 0.0;
      });
    });

    myRTDB.child('Sensor/humidity').onValue.listen((event) {
      final val = event.snapshot.value;
      setState(() {
        humidity = double.tryParse(val.toString()) ?? 0.0;
      });
    });

    myRTDB.child('Sensor/soilMoisture').onValue.listen((event) {
      final val = event.snapshot.value;
      setState(() {
        soilMoisture = int.tryParse(val.toString()) ?? 0;
      });
    });

    myRTDB.child('Sensor/tds').onValue.listen((event) {
      final val = event.snapshot.value;
      setState(() {
        tds = int.tryParse(val.toString()) ?? 0;
      });
    });

    myRTDB.child('Actuator/Pump').onValue.listen((event) {
      final val = event.snapshot.value;
      setState(() {
        pumpState = val == true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Farming Monitoring'),
        centerTitle: true,
        backgroundColor: const Color(0xFF79B7FF),
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            tooltip: 'Profile',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          color: Color(0xFFE6F7FF), // Solid color background
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  _buildSensorCard(
                    "Temperature",
                    "${temperature.toStringAsFixed(1)}°C",
                    Icons.thermostat,
                    _getTemperatureColor(temperature),
                  ),
                  _buildSensorCard(
                    "Humidity",
                    "${humidity.toStringAsFixed(1)}%",
                    Icons.water_drop,
                    _getHumidityColor(humidity),
                  ),
                  _buildSensorCard(
                    "Soil Moisture",
                    "$soilMoisture",
                    Icons.grass,
                    _getMoistureColor(soilMoisture),
                  ),
                  _buildSensorCard(
                    "TDS Level",
                    "$tds ppm",
                    Icons.science,
                    _getTdsColor(tds),
                  ),
                  const SizedBox(height: 30),
                  _buildPumpControlCard(),
                  const SizedBox(height: 20),
                  _buildDashboardButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getTemperatureColor(double temp) {
    if (temp < 15) return Colors.blue;
    if (temp > 30) return Colors.red;
    return Colors.green;
  }

  Color _getHumidityColor(double hum) {
    if (hum < 30) return Colors.orange;
    if (hum > 70) return Colors.blue;
    return Colors.green;
  }

  Color _getMoistureColor(int moisture) {
    if (moisture < 200) return Colors.orange;
    if (moisture > 400) return Colors.blue;
    return Colors.green;
  }

  Color _getTdsColor(int tdsValue) {
    if (tdsValue < 100) return Colors.orange;
    if (tdsValue > 300) return Colors.red;
    return Colors.green;
  }

  Widget _buildSensorCard(String title, String value, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [color.withOpacity(0.2), color.withOpacity(0.05)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 28, color: color),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          trailing: Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPumpControlCard() {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
            colors: [Color(0xFFE1F5FE), Color(0xFFE8F5E9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                "Water Pump Control",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton.icon(
                onPressed: () {
                  bool newPumpState = !pumpState;
                  myRTDB.child('Actuator/Pump').set(newPumpState);
                  setState(() {
                    pumpState = newPumpState;
                  });
                },
                icon: Icon(
                  pumpState ? Icons.toggle_on : Icons.toggle_off,
                  size: 30,
                ),
                label: Text(
                  pumpState ? "TURN PUMP OFF" : "TURN PUMP ON",
                  style: const TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: pumpState ? Colors.red : Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 15,
                  ),
                  elevation: 4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DashboardScreen()),
          );
        },
        icon: const Icon(Icons.analytics, size: 24),
        label: const Text(
          "VIEW DASHBOARD",
          style: TextStyle(fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF79B7FF),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          elevation: 4,
        ),
      ),
    );
  }
}
