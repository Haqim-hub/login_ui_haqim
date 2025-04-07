import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/welcome_page.dart';
import 'profile_page.dart';
import 'faqs_page.dart';
import 'controlling_page.dart'; // Import Controlling Page

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final DatabaseReference myRTDB = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: "https://smart-farming-ma-default-rtdb.asia-southeast1.firebasedatabase.app/",
  ).ref();

  String temperature = '0°C';
  String humidity = '0%';
  String soilMoisture = '0%';
  String gasLevel = '0 ppm';

  @override
  void initState() {
    super.initState();
    _readSensorValues();
  }

  void _readSensorValues() {
    myRTDB.child('Sensor/DHT22/Temperature').onValue.listen((event) {
      setState(() {
        temperature = '${event.snapshot.value}°C';
      });
    });

    myRTDB.child('Sensor/DHT22/Humidity').onValue.listen((event) {
      setState(() {
        humidity = '${event.snapshot.value}%';
      });
    });

    myRTDB.child('Sensor/SoilMoisture').onValue.listen((event) {
      setState(() {
        soilMoisture = '${event.snapshot.value}%';
      });
    });

    myRTDB.child('Sensor/MQ135').onValue.listen((event) {
      setState(() {
        gasLevel = '${event.snapshot.value} ppm';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Smart Monitoring Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              _showMenuDialog(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            _sensorCard('Temperature', Icons.thermostat, temperature, Colors.orange),
            _sensorCard('Humidity', Icons.water_drop, humidity, Colors.blue),
            _sensorCard('Soil Moisture', Icons.grass, soilMoisture, Colors.green),
            _sensorCard('Gas Level', Icons.gas_meter, gasLevel, Colors.red),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ControllingPage()),
                );
              },
              icon: Icon(Icons.electric_bolt),
              label: Text('Control Actuators'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _sensorCard(String title, IconData icon, String value, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5)),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 40, color: color),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Text(value, style: TextStyle(fontSize: 16, color: Colors.black54)),
            ],
          ),
        ],
      ),
    );
  }

  void _showMenuDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              menuItem(context, Icons.person, 'Profile', () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
              }),
              menuItem(context, Icons.help, 'FAQs', () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => FAQsPage()));
              }),
              menuItem(context, Icons.logout, 'Log Out', () {
                Navigator.pop(context);
                _showLogoutDialog(context);
              }),
            ],
          ),
        );
      },
    );
  }

  Widget menuItem(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(title, style: TextStyle(fontSize: 18)),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Log Out'),
        content: Text('Are you sure you want to log out?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => WelcomePage()),
                    (route) => false,
              );
            },
            child: Text('Log Out', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
