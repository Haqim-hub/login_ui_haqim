import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class IotControlling extends StatefulWidget {
  const IotControlling({super.key});

  @override
  State<IotControlling> createState() => _IotControllingState();
}

class _IotControllingState extends State<IotControlling> {
  final DatabaseReference myRTDB = FirebaseDatabase.instance.ref();
  bool pumpSwitch = false;

  // Read pump status from Firebase
  void loadSwitchStatus() {
    myRTDB.child('Actuator/Pump').onValue.listen((event) {
      final value = event.snapshot.value;
      if (value is bool) {
        setState(() {
          pumpSwitch = value;
        });
      }
    });
  }

  // Write pump status to Firebase
  void updatePumpSwitch(bool value) {
    myRTDB.child('Actuator/Pump').set(value);
    setState(() {
      pumpSwitch = value;
    });
  }

  @override
  void initState() {
    super.initState();
    loadSwitchStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actuator Control'),
        centerTitle: true,
        backgroundColor: const Color(0xFF79B7FF),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text('Kawalan Pam Air', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 20),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: const Icon(Icons.water, color: Colors.blue),
                  title: const Text('Pam'),
                  trailing: Switch(
                    value: pumpSwitch,
                    onChanged: updatePumpSwitch,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
