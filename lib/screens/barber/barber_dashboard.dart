import 'package:flutter/material.dart';

class BarberDashboard extends StatelessWidget {
  const BarberDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Dashboard', style: TextStyle(
          color: Colors.black
        ),),
      ),
    );
  }
}
