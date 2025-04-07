import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ControllingPage extends StatefulWidget {
  const ControllingPage({super.key});

  @override
  State<ControllingPage> createState() => _ControllingPageState();
}

class _ControllingPageState extends State<ControllingPage> {

  final DatabaseReference myRTDB = FirebaseDatabase.instance.ref();
  bool pumpSwitch = false;

  @override
  void initState() {
    super.initState();
    loadPumpStatus();
  }

  void loadPumpStatus(){
    myRTDB.child('Actuator/LED').onValue.listen((event){
      setState(() {
        pumpSwitch = event.snapshot.value as bool? ?? false;
      });
    });
  }

  void updatePumpSwitch(bool value) {
    myRTDB.child('Actuator/Pump').set(value);
    setState(() {
      pumpSwitch = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actuator Control'),
        centerTitle: false,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(padding: const EdgeInsets.all(8.0),
        child: Column(
            children: [
              SizedBox(height: 15),
              Card(
                color: Colors.white,
                child: ListTile(
                  title: Text('Pump'),
                  trailing: Switch(
                      value: pumpSwitch,
                      onChanged: (bool value){updatePumpSwitch(value);}
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

