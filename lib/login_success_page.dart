import 'package:flutter/material.dart';
import 'package:login_ui/dashboard_page.dart';
import 'package:login_ui/homepage.dart';

class LoginSuccessPage extends StatefulWidget {
  final String email;
  const LoginSuccessPage({super.key, required this.email});

  @override
  State<LoginSuccessPage> createState() => _LoginSuccessPageState();
}

class _LoginSuccessPageState extends State<LoginSuccessPage> {
  @override
  void initState() {
    super.initState();
    // Wait for 3 seconds, then navigate to the HomePage.
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homepage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // This screen only shows the logged in email message.
      body: Center(
        child: Text(
          "LOGGED IN AS: ${widget.email}",
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
